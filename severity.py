#app.py

from flask import Flask, request, jsonify
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer

app = Flask(__name__)

@app.route('/analyze', methods=['POST'])
def analyze():
    data = request.get_json()
    answer = data.get('answer')

    # Perform sentiment analysis
    severity = analyze_sentiment(answer)

    return jsonify({'severity': severity})

def analyze_sentiment(answer):
    # Use the VaderSentiment library for sentiment analysis
    analyzer = SentimentIntensityAnalyzer()
    sentiment_score = analyzer.polarity_scores(answer)['compound']

    # Set severity based on sentiment score
    if sentiment_score >= 0.05:
        return 'high'
    elif -0.05 < sentiment_score < 0.05:
        return 'moderate'
    else:
        return 'low'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
