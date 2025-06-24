import { useState } from 'react';
import { generateContent } from '../services/google-ai';
import VoiceInput from '../components/VoiceInput';
import ImageUpload from '../components/ImageUpload';

export default function ContentCreator() {
  const [topic, setTopic] = useState('');
  const [contentType, setContentType] = useState('blog');
  const [tone, setTone] = useState('friendly');
  const [content, setContent] = useState('');
  const [loading, setLoading] = useState(false);
  const [targetAudience, setTargetAudience] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!topic.trim()) return;
    
    setLoading(true);
    try {
      const prompt = `Create ${contentType} content about "${topic}". 
                     Tone: ${tone}. Target audience: ${targetAudience || 'general'}. 
                     Make it engaging and well-structured.`;
      
      const context = "You are a professional content creator. Generate high-quality content for various platforms.";
      const response = await generateContent(prompt, context);
      
      setContent(response);
    } catch (error) {
      setContent('Content creation failed: ' + error.message);
    } finally {
      setLoading(false);
    }
  };

  const handleVoiceResult = (text) => {
    setTopic(text);
  };

  const handleImageUpload = (file) => {
    setTopic(`Create content based on this image: ${file.name}`);
  };

  const downloadContent = () => {
    const blob = new Blob([content], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `${contentType}-content.txt`;
    a.click();
    URL.revokeObjectURL(url);
  };

  return (
    <div className="tool-page">
      <h2><i className="fas fa-pencil-alt"></i> Content Creator</h2>
      
      <form onSubmit={handleSubmit} className="tool-form">
        <div className="form-group">
          <label>Content Topic</label>
          <input
            type="text"
            value={topic}
            onChange={(e) => setTopic(e.target.value)}
            placeholder="What's your content about?"
            required
          />
        </div>
        
        <div className="input-group">
          <VoiceInput onResult={handleVoiceResult} />
          <ImageUpload onUpload={handleImageUpload} />
        </div>
        
        <div className="form-row">
          <div className="form-group">
            <label>Content Type</label>
            <select value={contentType} onChange={(e) => setContentType(e.target.value)}>
              <option value="blog">Blog Post</option>
              <option value="social">Social Media</option>
              <option value="newsletter">Newsletter</option>
              <option value="ad">Ad Copy</option>
              <option value="product">Product Description</option>
              <option value="email">Email Campaign</option>
            </select>
          </div>
          
          <div className="form-group">
            <label>Tone</label>
            <select value={tone} onChange={(e) => setTone(e.target.value)}>
              <option value="friendly">Friendly</option>
              <option value="professional">Professional</option>
              <option value="humorous">Humorous</option>
              <option value="authoritative">Authoritative</option>
              <option value="inspirational">Inspirational</option>
            </select>
          </div>
        </div>
        
        <div className="form-group">
          <label>Target Audience</label>
          <input
            type="text"
            value={targetAudience}
            onChange={(e) => setTargetAudience(e.target.value)}
            placeholder="e.g. Young professionals, Parents"
          />
        </div>
        
        <button type="submit" disabled={loading}>
          {loading ? 'Creating...' : 'Generate Content'}
        </button>
      </form>
      
      {content && (
        <div className="results-container">
          <div className="results-content">{content}</div>
          
          <div className="tool-actions">
            <button onClick={() => navigator.clipboard.writeText(content)}>
              <i className="fas fa-copy"></i> Copy
            </button>
            <button onClick={downloadContent}>
              <i className="fas fa-download"></i> Save Content
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
