from flask import Flask, request, jsonify
import numpy as np
import pandas as pd
import requests
from sklearn.preprocessing import LabelEncoder
from keras.models import Model
from keras.layers import Input, Dense, Concatenate
from apscheduler.schedulers.background import BackgroundScheduler
import atexit
from keras.optimizers import Adam
app = Flask(__name__)

# Global variables to store model and encoders
model = None
city_encoder = None
gender_encoder = None


# Helper function to fetch data from API
def fetch_data():
    user_api_url = "https://wheel-n-deal-production.up.railway.app/api/v1/AI/get-all-users"
    commuter_api_url = "https://wheel-n-deal-production.up.railway.app/api/v1/user/getCommuterTripDTO"
    reviews_api_url = "https://wheel-n-deal-production.up.railway.app/api/v1/AI/get-all-reviews"
    userdf = pd.DataFrame(requests.get(user_api_url).json()['data'])
    commuterdf = pd.DataFrame(requests.get(commuter_api_url).json())
    reviewsdf = pd.DataFrame(requests.get(reviews_api_url).json())
    return userdf, commuterdf, reviewsdf


def fetch_commuter():
    commuter_api_url = "https://wheel-n-deal-production.up.railway.app/api/v1/user/getCommuterTripDTO"
    commuterdf = pd.DataFrame(requests.get(commuter_api_url).json())
    return commuterdf


# Function to preprocess data and train the model
def preprocess_and_train_model():
    global model, city_encoder, gender_encoder

    df_user, df_commuter, reviews = fetch_data()
    df_user.fillna('unknown', inplace=True)
    df_commuter.dropna(inplace=True)
    reviews.dropna(inplace=True)

    print("training..")
    # df_user = pd.read_csv("users.csv")
    # df_commuter = pd.read_csv("commuters.csv")
    reviews_users_df = reviews.merge(df_user, how='left', left_on='reviewer', right_on='id')
    df = reviews_users_df.merge(df_commuter, how='left', left_on='reviewee', right_on='commuterId')
    cities = np.unique(
        np.append(
            np.append(df_user['city'].unique(), df_commuter['city'].unique()),
            np.append(df_commuter['movingFrom'].unique(), df_commuter['goesTo'].unique())

        )
    )
    cities = np.append(cities, "unknown")

    genders = np.unique(
        np.append(df_user['gender'].unique(), df_commuter['gender'].unique())
    )
    genders = np.append(genders, 'unknown')

    city_encoder = LabelEncoder()
    gender_encoder = LabelEncoder()

    city_encoder.fit(cities)
    gender_encoder.fit(genders)
    df.dropna(inplace=True)
    df['city_x'] = city_encoder.transform(df['city_x'])
    df['gender_x'] = gender_encoder.transform(df['gender_x'])
    df['gender_y'] = gender_encoder.transform(df['gender_y'])
    df['city_y'] = city_encoder.transform(df['city_y'])
    df['movingFrom'] = city_encoder.transform(df['movingFrom'])
    df['goesTo'] = city_encoder.transform(df['goesTo'])

    y = df['rate'].values.reshape(-1, 1)
    x_user = df[['city_x', 'gender_x']].values
    x_commuter = df[['city_y', 'gender_y', 'avgRate', 'movingFrom', 'goesTo']].values
    user_input = Input(shape=(2,), name='user_input')
    commuter_input = Input(shape=(5,), name='commuter_input')

    # Define dense layers for user and commuter data
    user_dense = Dense(64, activation='relu')(user_input)
    commuter_dense = Dense(64, activation='relu')(commuter_input)

    # Concatenate the user and commuter dense layers
    concat_layer = Concatenate()([user_dense, commuter_dense])

    # Define the output layer
    x = Dense(50, activation='relu')(concat_layer)
    output_layer = Dense(1)(x)
    # Define the model
    model = Model(inputs=[user_input, commuter_input], outputs=output_layer)

    # Compile the model
    model.compile(optimizer=Adam(learning_rate=0.001), loss='mean_squared_error')

    # Train the model
    model.fit([x_user, x_commuter], y, epochs=16, batch_size=32)
    # Print the model summary
    model.summary()



def scheduled_job():
    print("Retraining model...")
    preprocess_and_train_model()
    print("Model retrained!")


# Schedule the retraining job every Friday at 00:00
scheduler = BackgroundScheduler()
scheduler.add_job(func=scheduled_job, trigger='cron', day_of_week='fri', hour=0, minute=0)
scheduler.start()

# Ensure that the scheduler shuts down properly when exiting the app
atexit.register(lambda: scheduler.shutdown())


@app.route('/recommend', methods=['POST'])
def recommend():
    try:
        data = request.json
        user_data = data['user']
        k = data['top_k']

        user_data_encoded = np.array([
            city_encoder.transform([user_data['city']])[0],
            gender_encoder.transform([user_data['gender']])[0]
        ]).reshape(1, -1)

        df_commuter = fetch_commuter()
        df_commuter['city'] = city_encoder.transform(df_commuter['city'])
        df_commuter['gender'] = gender_encoder.transform(df_commuter['gender'])
        df_commuter['movingFrom'] = city_encoder.transform(df_commuter['movingFrom'])
        df_commuter['goesTo'] = city_encoder.transform(df_commuter['goesTo'])

        # Repeat the user to the same number of commuters
        commuter_data_encoded = df_commuter[['city', 'gender', 'avgRate', 'movingFrom', 'goesTo']].values
        user_data_encoded = user_data_encoded.tolist()
        rows = commuter_data_encoded.shape[0]
        user_data_encoded = user_data_encoded * rows
        user_data_encoded = np.array(user_data_encoded).reshape(rows, 2)
        predictions = model.predict([user_data_encoded, commuter_data_encoded])
        df_commuter['Predicted_Rating'] = predictions
        print(predictions)
        df_commuter.sort_values(by='Predicted_Rating' ,inplace=True)
        df_commuter.drop_duplicates(subset='commuterId', keep='first', inplace=True)
        top_k_commuters = df_commuter.nlargest(k, 'Predicted_Rating')

        print(df_commuter['commuterId'])
        return jsonify(top_k_commuters[['commuterId']].values.reshape(1,-1).tolist())
    except Exception as e:
        print(f"Error: {str(e)}")
        return jsonify({"error": str(e)}), 500


@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({"status": "Server is up and running"}), 200


if __name__ == '__main__':
    # Initial training of the model when the app starts
    preprocess_and_train_model()
    app.run(debug=True)
