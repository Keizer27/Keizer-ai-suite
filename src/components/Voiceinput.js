import { useState, useEffect } from 'react';

export default function VoiceInput({ onResult }) {
  const [isListening, setIsListening] = useState(false);
  const [recognition, setRecognition] = useState(null);

  useEffect(() => {
    const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
    if (SpeechRecognition) {
      const recognizer = new SpeechRecognition();
      recognizer.continuous = false;
      recognizer.lang = 'en-US';
      
      recognizer.onresult = (event) => {
        const transcript = event.results[0][0].transcript;
        onResult(transcript);
        setIsListening(false);
      };
      
      recognizer.onerror = (event) => {
        console.error('Speech recognition error:', event.error);
        setIsListening(false);
      };
      
      setRecognition(recognizer);
    }
  }, [onResult]);

  const toggleListening = () => {
    if (isListening) {
      recognition.stop();
      setIsListening(false);
    } else {
      recognition.start();
      setIsListening(true);
    }
  };

  return (
    <button 
      className={`voice-input-btn ${isListening ? 'listening' : ''}`}
      onClick={toggleListening}
      disabled={!recognition}
    >
      <i className={`fas ${isListening ? 'fa-microphone-alt-slash' : 'fa-microphone-alt'}`}></i>
    </button>
  );
}
