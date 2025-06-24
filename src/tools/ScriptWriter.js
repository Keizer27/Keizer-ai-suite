import { useState } from 'react';
import { generateContent } from '../services/google-ai';
import VoiceInput from '../components/VoiceInput';

export default function ScriptWriter() {
  const [title, setTitle] = useState('');
  const [scriptType, setScriptType] = useState('video');
  const [genre, setGenre] = useState('');
  const [characters, setCharacters] = useState('');
  const [script, setScript] = useState('');
  const [loading, setLoading] = useState(false);
  const [length, setLength] = useState('short');

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!title.trim()) return;
    
    setLoading(true);
    try {
      const prompt = `Write a ${scriptType} script titled "${title}". 
                     Genre: ${genre || 'any'}. Characters: ${characters || 'unspecified'}. 
                     Length: ${length}. Format with scene headings, action lines, and dialogue.`;
      
      const context = "You are a professional screenwriter. Create engaging scripts with proper formatting.";
      const response = await generateContent(prompt, context);
      
      setScript(response);
    } catch (error) {
      setScript('Script writing failed: ' + error.message);
    } finally {
      setLoading(false);
    }
  };

  const handleVoiceResult = (text, field) => {
    switch(field) {
      case 'title': setTitle(text); break;
      case 'genre': setGenre(text); break;
      case 'characters': setCharacters(text); break;
      default: break;
    }
  };

  const downloadScript = () => {
    const blob = new Blob([script], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `${title}-script.txt`;
    a.click();
    URL.revokeObjectURL(url);
  };

  return (
    <div className="tool-page">
      <h2><i className="fas fa-scroll"></i> Script Writer</h2>
      
      <form onSubmit={handleSubmit} className="tool-form">
        <div className="form-group">
          <label>Script Title</label>
          <div className="input-with-voice">
            <input
              type="text"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              placeholder="Script title"
              required
            />
            <VoiceInput onResult={(text) => handleVoiceResult(text, 'title')} />
          </div>
        </div>
        
        <div className="form-row">
          <div className="form-group">
            <label>Script Type</label>
            <select value={scriptType} onChange={(e) => setScriptType(e.target.value)}>
              <option value="video">Video/Movie</option>
              <option value="tv">TV Show</option>
              <option value="play">Stage Play</option>
              <option value="podcast">Podcast</option>
              <option value="commercial">Commercial</option>
            </select>
          </div>
          
          <div className="form-group">
            <label>Length</label>
            <select value={length} onChange={(e) => setLength(e.target.value)}>
              <option value="short">Short (1-3 min)</option>
              <option value="medium">Medium (5-10 min)</option>
              <option value="long">Long (15+ min)</option>
            </select>
          </div>
        </div>
        
        <div className="form-row">
          <div className="form-group">
            <label>Genre</label>
            <div className="input-with-voice">
              <input
                type="text"
                value={genre}
                onChange={(e) => setGenre(e.target.value)}
                placeholder="e.g. Comedy, Drama"
              />
              <VoiceInput onResult={(text) => handleVoiceResult(text, 'genre')} />
            </div>
          </div>
          
          <div className="form-group">
            <label>Main Characters</label>
            <div className="input-with-voice">
              <input
                type="text"
                value={characters}
                onChange={(e) => setCharacters(e.target.value)}
                placeholder="Character names"
              />
              <VoiceInput onResult={(text) => handleVoiceResult(text, 'characters')} />
            </div>
          </div>
        </div>
        
        <button type="submit" disabled={loading}>
          {loading ? 'Writing...' : 'Generate Script'}
        </button>
      </form>
      
      {script && (
        <div className="results-container">
          <div className="results-content">
            <pre>{script}</pre>
          </div>
          
          <div className="tool-actions">
            <button onClick={() => navigator.clipboard.writeText(script)}>
              <i className="fas fa-copy"></i> Copy
            </button>
            <button onClick={downloadScript}>
              <i className="fas fa-download"></i> Save Script
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
