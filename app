from flask import Flask, render_template, request, jsonify
import speech_recognition as sr
import pyttsx3
from models.speech_to_text_model import speech_to_text
from models.text_to_speech_model import text_to_speech

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/process_audio', methods=['POST'])
def process_audio():
    if 'audio' not in request.files:
        return jsonify({'error': 'No audio file provided.'})

    audio_file = request.files['audio']
    
    # Convert speech to text
    text = speech_to_text(audio_file)
    response_text = "You said: " + text

    # Convert text to speech
    audio_response = text_to_speech(response_text)
    
    return jsonify({'response': response_text, 'audio_response': audio_response})

if __name__ == '__main__':
    app.run(debug=True)
