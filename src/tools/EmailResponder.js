import { useState } from 'react';
import { generateContent } from '../services/google-ai';
import VoiceInput from '../components/VoiceInput';

export default function EmailResponder() {
  const [emailContent, setEmailContent] = useState('');
  const [tone, setTone] = useState('professional');
  const [keyPoints, setKeyPoints] = useState('');
  const [response, setResponse] = useState('');
  const [loading, setLoading] = useState(false);
  const [length, setLength] = useState('medium');

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!emailContent.trim()) return;
    
    setLoading(true);
    try {
      const prompt = `Compose a ${tone} email response to this message: ${emailContent}. 
                     Key points to include: ${keyPoints || 'none'}. 
                     Length: ${length}. Include appropriate greeting and closing.`;
      
      const context = "You are an email response expert. Craft professional email responses.";
      const generatedResponse = await generateContent(prompt, context);
      
      setResponse(generatedResponse);
    } catch (error) {
      setResponse('Email generation failed: ' + error.message);
    } finally {
      setLoading(false);
    }
  };

  const handleVoiceResult = (text, field) => {
    switch(field) {
      case 'email': setEmailContent(text); break;
      case 'points': setKeyPoints(text); break;
      default: break;
    }
  };

  const downloadResponse = () => {
    const blob = new Blob([response], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'email-response.txt';
    a.click();
    URL.revokeObjectURL(url);
  };

  return (
    <div className="tool-page">
      <h2><i className="fas fa-envelope"></i> Email Responder</h2>
      
      <form onSubmit={handleSubmit} className="tool-form">
        <div className="form-group">
          <label>Email to Respond To</label>
          <div className="input-with-voice">
            <textarea
              value={emailContent}
              onChange={(e) => setEmailContent(e.target.value)}
              placeholder="Paste the email content here"
              rows="4"
              required
            />
            <VoiceInput onResult={(text) => handleVoiceResult(text, 'email')} />
          </div>
        </div>
        
        <div className="form-row">
          <div className="form-group">
            <label>Response Tone</label>
            <select value={tone} onChange={(e) => setTone(e.target.value)}>
              <option value="professional">Professional</option>
              <option value="friendly">Friendly</option>
              <option value="formal">Formal</option>
              <option value="concise">Concise</option>
            </select>
          </div>
          
          <div className="form-group">
            <label>Response Length</label>
            <select value={length} onChange={(e) => setLength(e.target.value)}>
              <option value="short">Short</option>
              <option value="medium">Medium</option>
              <option value="detailed">Detailed</option>
            </select>
          </div>
        </div>
        
        <div className="form-group">
          <label>Key Points to Include</label>
          <div className="input-with-voice">
            <textarea
              value={keyPoints}
              onChange={(e) => setKeyPoints(e.target.value)}
              placeholder="Main points you want to include in your response"
              rows="2"
            />
            <VoiceInput onResult={(text) => handleVoiceResult(text, 'points')} />
          </div>
        </div>
        
        <button type="submit" disabled={loading}>
          {loading ? 'Generating...' : 'Generate Response'}
        </button>
      </form>
      
      {response && (
        <div className="results-container">
          <div className="results-content">
            <pre>{response}</pre>
          </div>
          
          <div className="tool-actions">
            <button onClick={() => navigator.clipboard.writeText(response)}>
              <i className="fas fa-copy"></i> Copy
            </button>
            <button onClick={downloadResponse}>
              <i className="fas fa-download"></i> Save as TXT
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
