import { useState } from 'react';
import { generateContent } from '../services/google-ai';
import VoiceInput from '../components/VoiceInput';
import ImageUpload from '../components/ImageUpload';

export default function SocialMedia() {
  const [content, setContent] = useState('');
  const [platform, setPlatform] = useState('twitter');
  const [tone, setTone] = useState('engaging');
  const [post, setPost] = useState('');
  const [loading, setLoading] = useState(false);
  const [hashtags, setHashtags] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!content.trim()) return;
    
    setLoading(true);
    try {
      const prompt = `Create a ${tone} social media post for ${platform} about: ${content}. 
                     Hashtags: ${hashtags || 'include relevant hashtags'}. 
                     Format appropriately for the platform.`;
      
      const context = "You are a social media expert. Create engaging content for various platforms.";
      const generatedPost = await generateContent(prompt, context);
      
      setPost(generatedPost);
    } catch (error) {
      setPost('Post creation failed: ' + error.message);
    } finally {
      setLoading(false);
    }
  };

  const handleVoiceResult = (text) => {
    setContent(text);
  };

  const handleImageUpload = (file) => {
    setContent(`Create a social media post for this image: ${file.name}`);
  };

  const downloadPost = () => {
    const blob = new Blob([post], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `${platform}-post.txt`;
    a.click();
    URL.revokeObjectURL(url);
  };

  return (
    <div className="tool-page">
      <h2><i className="fas fa-share-alt"></i> Social Media Post</h2>
      
      <form onSubmit={handleSubmit} className="tool-form">
        <div className="form-group">
          <label>Post Content</label>
          <textarea
            value={content}
            onChange={(e) => setContent(e.target.value)}
            placeholder="What do you want to post about?"
            rows="3"
            required
          />
        </div>
        
        <div className="input-group">
          <VoiceInput onResult={handleVoiceResult} />
          <ImageUpload onUpload={handleImageUpload} />
        </div>
        
        <div className="form-row">
          <div className="form-group">
            <label>Platform</label>
            <select value={platform} onChange={(e) => setPlatform(e.target.value)}>
              <option value="twitter">Twitter/X</option>
              <option value="facebook">Facebook</option>
              <option value="instagram">Instagram</option>
              <option value="linkedin">LinkedIn</option>
              <option value="tiktok">TikTok</option>
            </select>
          </div>
          
          <div className="form-group">
            <label>Tone</label>
            <select value={tone} onChange={(e) => setTone(e.target.value)}>
              <option value="engaging">Engaging</option>
              <option value="professional">Professional</option>
              <option value="funny">Funny</option>
              <option value="inspirational">Inspirational</option>
              <option value="urgent">Urgent</option>
            </select>
          </div>
        </div>
        
        <div className="form-group">
          <label>Hashtags (optional)</label>
          <input
            type="text"
            value={hashtags}
            onChange={(e) => setHashtags(e.target.value)}
            placeholder="#example #hashtags"
          />
        </div>
        
        <button type="submit" disabled={loading}>
          {loading ? 'Creating...' : 'Generate Post'}
        </button>
      </form>
      
      {post && (
        <div className="results-container">
          <div className="results-content">
            <pre>{post}</pre>
          </div>
          
          <div className="tool-actions">
            <button onClick={() => navigator.clipboard.writeText(post)}>
              <i className="fas fa-copy"></i> Copy
            </button>
            <button onClick={downloadPost}>
              <i className="fas fa-download"></i> Save Post
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
