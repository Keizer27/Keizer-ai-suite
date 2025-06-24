import { useState } from 'react';
import { generateContent } from '../services/google-ai';
import VoiceInput from '../components/VoiceInput';

export default function ResumeWriter() {
  const [name, setName] = useState('');
  const [title, setTitle] = useState('');
  const [experience, setExperience] = useState('');
  const [skills, setSkills] = useState('');
  const [education, setEducation] = useState('');
  const [resume, setResume] = useState('');
  const [loading, setLoading] = useState(false);
  const [template, setTemplate] = useState('modern');

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!name || !title || !experience) return;
    
    setLoading(true);
    try {
      const prompt = `Create a ${template}-style resume for ${name}, a ${title} with ${experience} years of experience.
                     Skills: ${skills}. Education: ${education || 'Not specified'}. 
                     Include sections: Summary, Experience, Skills, Education.`;
      
      const context = "You are a professional resume writer. Create a well-formatted resume document.";
      const response = await generateContent(prompt, context);
      
      setResume(response);
    } catch (error) {
      setResume('Resume generation failed: ' + error.message);
    } finally {
      setLoading(false);
    }
  };

  const handleVoiceResult = (text, field) => {
    switch(field) {
      case 'name': setName(text); break;
      case 'title': setTitle(text); break;
      case 'skills': setSkills(text); break;
      default: break;
    }
  };

  const downloadResume = () => {
    const blob = new Blob([resume], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `${name}-resume.txt`;
    a.click();
    URL.revokeObjectURL(url);
  };

  return (
    <div className="tool-page">
      <h2><i className="fas fa-file-contract"></i> Resume Writer</h2>
      
      <form onSubmit={handleSubmit} className="tool-form">
        <div className="form-row">
          <div className="form-group">
            <label>Full Name</label>
            <div className="input-with-voice">
              <input
                type="text"
                value={name}
                onChange={(e) => setName(e.target.value)}
                placeholder="Your name"
                required
              />
              <VoiceInput onResult={(text) => handleVoiceResult(text, 'name')} />
            </div>
          </div>
          
          <div className="form-group">
            <label>Professional Title</label>
            <div className="input-with-voice">
              <input
                type="text"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
                placeholder="e.g. Software Engineer"
                required
              />
              <VoiceInput onResult={(text) => handleVoiceResult(text, 'title')} />
            </div>
          </div>
        </div>
        
        <div className="form-row">
          <div className="form-group">
            <label>Experience (years)</label>
            <input
              type="number"
              value={experience}
              onChange={(e) => setExperience(e.target.value)}
              min="0"
              required
            />
          </div>
          
          <div className="form-group">
            <label>Resume Template</label>
            <select value={template} onChange={(e) => setTemplate(e.target.value)}>
              <option value="modern">Modern</option>
              <option value="professional">Professional</option>
              <option value="creative">Creative</option>
              <option value="minimalist">Minimalist</option>
            </select>
          </div>
        </div>
        
        <div className="form-group">
          <label>Key Skills</label>
          <div className="input-with-voice">
            <textarea
              value={skills}
              onChange={(e) => setSkills(e.target.value)}
              placeholder="List your skills, comma separated"
              rows="2"
            />
            <VoiceInput onResult={(text) => handleVoiceResult(text, 'skills')} />
          </div>
        </div>
        
        <div className="form-group">
          <label>Education</label>
          <textarea
            value={education}
            onChange={(e) => setEducation(e.target.value)}
            placeholder="Your educational background"
            rows="2"
          />
        </div>
        
        <button type="submit" disabled={loading}>
          {loading ? 'Generating...' : 'Create Resume'}
        </button>
      </form>
      
      {resume && (
        <div className="results-container">
          <div className="results-content">{resume}</div>
          
          <div className="tool-actions">
            <button onClick={() => navigator.clipboard.writeText(resume)}>
              <i className="fas fa-copy"></i> Copy
            </button>
            <button onClick={downloadResume}>
              <i className="fas fa-download"></i> Save as DOC
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
