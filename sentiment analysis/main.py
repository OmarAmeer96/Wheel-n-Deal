from flask import Flask, request, jsonify
from Sentiment_Response import SentimentResponse
from sentiment_analysis import *

app = Flask(__name__)


@app.route('/', methods=['POST'])
def sentiment():
    try:
        data = request.json
        input_list = data.get('message')
        input_list = [input_list]
        # Perform operations on the list (for example, reverse it)
        output_list = sentiment_analysis(input_list)
        out = SentimentResponse(input_list[0], **output_list[0]).__dict__

        print(out)
        # Return the processed list
        return jsonify({'classes': out})
    except Exception as e:
        return jsonify({'error': str(e)})


if __name__ == '__main__':
    app.run(debug=True)
