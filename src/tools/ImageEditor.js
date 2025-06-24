import { useState, useRef } from 'react';
import { generateContent } from '../services/google-ai';
import ImageUpload from '../components/ImageUpload';

export default function ImageEditor() {
  const [image, setImage] = useState(null);
  const [instruction, setInstruction] = useState('');
  const [loading, setLoading] = useState(false);
  const [resultImage, setResultImage] = useState(null);
  const [enhanceType, setEnhanceType] = useState('general');
  const fileInputRef = useRef();

  const handleImageUpload = (file) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      setImage(e.target.result);
    };
    reader.readAsDataURL(file);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!image || (!instruction && enhanceType === 'custom')) return;
    
    setLoading(true);
    try {
      // In a real app, we'd send to Google Cloud Vision API
      // For demo, we'll simulate with a text description
      const prompt = enhanceType === 'custom' 
        ? instruction 
        : `Apply ${enhanceType} enhancement to this image`;
      
      const context = "You are an AI image editor. Describe the enhanced image:";
      const description = await generateContent(prompt, context);
      
      // Simulate image result
      setResultImage({
        description,
        url: image // In real app, this would be the processed image URL
      });
    } catch (error) {
      alert('Image processing failed: ' + error.message);
    } finally {
      setLoading(false);
    }
  };

  const downloadImage = () => {
    if (!resultImage) return;
    
    const a = document.createElement('a');
    a.href = resultImage.url;
    a.download = 'keizer-enhanced-image.png';
    a.click();
  };

  return (
    <div className="tool-page">
      <h2><i className="fas fa-image"></i> Image Editor</h2>
      
      <form onSubmit={handleSubmit} className="tool-form">
        <div className="image-upload-container">
          {image ? (
            <div className="image-preview-container">
              <img src={image} alt="Original" className="image-preview" />
              <button 
                type="button" 
                className="change-image-btn"
                onClick={() => fileInputRef.current.click()}
              >
                Change Image
              </button>
            </div>
          ) : (
            <ImageUpload 
              onUpload={handleImageUpload} 
              ref={fileInputRef}
              fullWidth
            />
          )}
        </div>
        
        <div className="form-group">
          <label>Enhancement Type</label>
          <select 
            value={enhanceType} 
            onChange={(e) => setEnhanceType(e.target.value)}
          >
            <option value="general">General Enhancement</option>
            <option value="color-correction">Color Correction</option>
            <option value="background-remove">Remove Background</option>
            <option value="sharpening">Sharpening</option>
            <option value="noise-reduction">Noise Reduction</option>
            <option value="custom">Custom Instruction</option>
          </select>
        </div>
        
        {enhanceType === 'custom' && (
          <div className="form-group">
            <label>Editing Instructions</label>
            <textarea
              value={instruction}
              onChange={(e) => setInstruction(e.target.value)}
              placeholder="Describe what changes you want to make"
              rows="3"
              required
            />
          </div>
        )}
        
        <button type="submit" disabled={!image || loading}>
          {loading ? 'Processing...' : 'Enhance Image'}
        </button>
      </form>
      
      {resultImage && (
        <div className="results-container">
          <h3>Enhanced Image</h3>
          
          <div className="image-result-container">
            <img src={resultImage.url} alt="Enhanced" className="image-result" />
            <div className="image-description">
              <p><strong>AI Description:</strong> {resultImage.description}</p>
            </div>
          </div>
          
          <div className="tool-actions">
            <button onClick={() => navigator.clipboard.writeText(resultImage.description)}>
              <i className="fas fa-copy"></i> Copy Description
            </button>
            <button onClick={downloadImage}>
              <i className="fas fa-download"></i> Download Image
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
