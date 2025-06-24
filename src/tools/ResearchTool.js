import { useState } from 'react';
import { generateContent } from '../services/google-ai';
import VoiceInput from '../components/VoiceInput';
import ImageUpload from '../components/ImageUpload';

export default function ResearchTool() {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState('');
  const [loading, setLoading] = useState(false);
  const [format, setFormat] = useState('APA');
  const [sources, setSources] = useState([]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!query.trim()) return;
    
    setLoading(true);
    try {
      const context = `You are a research assistant. Provide detailed information with ${format} citations about:`;
      const response = await generateContent(query, context);
      
      // Extract sources from response
      const extractedSources = extractSources(response);
      
      setResults(response);
      setSources(extractedSources);
    } catch (error) {
      setResults('Research failed: ' + error.message);
    } finally {
      setLoading(false);
    }
  };

  const handleVoiceResult = (text) => {
    setQuery(text);
  };

  const handleImageUpload = (file) => {
    // For research, we can process images with OCR
    setQuery(`Research based on this image: ${file.name}`);
  };

  const downloadResults = () => {
    const blob = new Blob([results], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'research-results.txt';
    a.click();
    URL.revokeObjectURL(url);
  };

  // Helper to extract sources from text
  const extractSources = (text) => {
    // This would be more sophisticated in a real implementation
    const sourceRegex = /\(([^)]+)\)/g;
    const matches = [];
    let match;
    
    while ((match = sourceRegex.exec(text)) !== null) {
      matches.push(match[1]);
    }
    
    return matches.slice(0, 5); // Return top 5 sources
  };

  return (
    <div className="tool-page">
      <h2><i className="fas fa-search"></i> Research Assistant</h2>
      
      <form onSubmit={handleSubmit} className="tool-form">
        <div className="input-group">
          <input
            type="text"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Enter research topic..."
            required
          />
          <VoiceInput onResult={handleVoiceResult} />
          <ImageUpload onUpload={handleImageUpload} />
        </div>

        <div className="format-selector">
          <label>Reference Format:</label>
          <select value={format} onChange={(e) => setFormat(e.target.value)}>
            <option value="APA">APA</option>
            <option value="MLA">MLA</option>
            <option value="Chicago">Chicago</option>
            <option value="IEEE">IEEE</option>
            <option value="Harvard">Harvard</option>
          </select>
        </div>

        <button type="submit" disabled={loading}>
          {loading ? 'Researching...' : 'Start Research'}
        </button>
      </form>

      {results && (
        <div className="results-container">
          <div className="results-content">{results}</div>
          
          {sources.length > 0 && (
            <div className="sources-section">
              <h3>References</h3>
              <ul>
                {sources.map((source, index) => (
                  <li key={index}>{source}</li>
                ))}
              </ul>
            </div>
          )}
          
          <div className="tool-actions">
            <button onClick={() => navigator.clipboard.writeText(results)}>
              <i className="fas fa-copy"></i> Copy
            </button>
            <button onClick={downloadResults}>
              <i className="fas fa-download"></i> Save
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
