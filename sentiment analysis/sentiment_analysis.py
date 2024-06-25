from transformers import pipeline

pipline = pipeline("sentiment-analysis")


def sentiment_analysis(comments: list):
    out = pipline.predict(comments)
    return out

