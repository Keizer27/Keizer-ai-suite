import { useState } from 'react';
import { generateContent } from '../services/google-ai';
import VoiceInput from '../components/VoiceInput';
import ImageUpload from '../components/ImageUpload';

export default function ArticleWriter() {
  const [topic, setTopic] = useState('');
  const [tone, setTone] = useState('professional');
  const [length, setLength] = useState('medium');
  const [article, setArticle] = useState('');
  const [loading, setLoading] = useState(false);
  const [keywords, setKeywords] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!topic.trim()) return;
    
    setLoading(true);
    try {
      const prompt = `Write a ${tone}-tone article about "${topic}". 
                     Length: ${length}. Keywords: ${keywords || 'none'}. 
                     Include an introduction, body paragraphs, and conclusion.`;
      
      const context = "You are a professional journalist writing for a major publication.";
      const response = await generateContent(prompt, context);
      
      setArticle(response);
    } catch (error) {
      setArticle('Article generation failed: ' + error.message);
    } finally {
      setLoading(false);
    }
  };

  const handleVoiceResult = (text) => {
    setTopic(text);
  };

  const handleImageUpload = (file) => {
    setTopic(`Write an article based on this image: ${file.name}`);
  };

  const downloadArticle = () => {
    const blob = new Blob([article], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `${topic}-article.txt`;
    a.click();
    URL.revokeObjectURL(url);
  };

  return (
    <div className="tool-page">
      <h2><i className="fas fa-newspaper"></i> Article Writer</h2>
      
      <form onSubmit={handleSubmit} className="tool-form">
        <div className="form-group">
          <label>Article Topic</label>
          <input
            type="text"
            value={topic}
            onChange={(e) => setTopic(e.target.value)}
            placeholder="Enter article topic..."
            required
          />
        </div>
        
        <div className="input-group">
          <VoiceInput onResult={handleVoiceResult} />
          <ImageUpload onUpload={handleImageUpload} />
        </div>
        
        <div className="form-row">
          <div className="form-group">
            <label>Tone</label>
            <select value={tone} onChange={(e) => setTone(e.target.value)}>
              <option value="professional">Professional</option>
              <option value="casual">Casual</option>
              <option value="academic">Academic</option>
              <option value="journalistic">Journalistic</option>
            </select>
          </div>
          
          <div className="form-group">
            <label>Length</label>
            <select value={length} onChange={(e) => setLength(e.target.value)}>
              <option value="short">Short (300 words)</option>
              <option value="medium">Medium (600 words)</option>
              <option value="long">Long (1000+ words)</option>
            </select>
          </div>
        </div>
        
        <div className="form-group">
          <label>Keywords (optional)</label>
          <input
            type="text"
            value={keywords}
            onChange={(e) => setKeywords(e.target.value)}
            placeholder="SEO keywords, comma separated"
          />
        </div>
        
        <button type="submit" disabled={loading}>
          {loading ? 'Writing...' : 'Generate Article'}
        </button>
      </form>
      
      {article && (
        <div className="results-container">
          <div className="results-content">{article}</div>
          
          <div className="tool-actions">
            <button onClick={() => navigator.clipboard.writeText(article)}>
              <i className="fas fa-copy"></i> Copy
            </button>
            <button onClick={downloadArticle}>
              <i className="fas fa-download"></i> Save
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
