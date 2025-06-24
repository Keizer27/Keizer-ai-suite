import { useState } from 'react';
import { generateContent } from '../services/google-ai';
import VoiceInput from '../components/VoiceInput';
import ImageUpload from '../components/ImageUpload';

export default function MathSolver() {
  const [problem, setProblem] = useState('');
  const [solution, setSolution] = useState('');
  const [loading, setLoading] = useState(false);
  const [explanationLevel, setExplanationLevel] = useState('steps');
  const [mathArea, setMathArea] = useState('algebra');

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!problem.trim()) return;
    
    setLoading(true);
    try {
      let prompt = `Solve this ${mathArea} problem: ${problem}. `;
      
      if (explanationLevel === 'steps') {
        prompt += "Show each step of the solution process.";
      } else if (explanationLevel === 'detailed') {
        prompt += "Provide a detailed explanation of the solution.";
      } else {
        prompt += "Provide just the final answer.";
      }
      
      const context = "You are a math expert. Provide accurate solutions with proper mathematical notation.";
      const response = await generateContent(prompt, context);
      
      setSolution(response);
    } catch (error) {
      setSolution('Solution failed: ' + error.message);
    } finally {
      setLoading(false);
    }
  };

  const handleVoiceResult = (text) => {
    setProblem(text);
  };

  const handleImageUpload = (file) => {
    setProblem(`Solve the math problem in this image: ${file.name}`);
  };

  const downloadSolution = () => {
    const blob = new Blob([solution], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'math-solution.txt';
    a.click();
    URL.revokeObjectURL(url);
  };

  return (
    <div className="tool-page">
      <h2><i className="fas fa-square-root-alt"></i> Math Solver</h2>
      
      <form onSubmit={handleSubmit} className="tool-form">
        <div className="form-group">
          <label>Math Problem</label>
          <textarea
            value={problem}
            onChange={(e) => setProblem(e.target.value)}
            placeholder="Enter your math problem or equation"
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
            <label>Math Area</label>
            <select value={mathArea} onChange={(e) => setMathArea(e.target.value)}>
              <option value="algebra">Algebra</option>
              <option value="geometry">Geometry</option>
              <option value="calculus">Calculus</option>
              <option value="statistics">Statistics</option>
              <option value="trigonometry">Trigonometry</option>
            </select>
          </div>
          
          <div className="form-group">
            <label>Explanation Level</label>
            <select value={explanationLevel} onChange={(e) => setExplanationLevel(e.target.value)}>
              <option value="answer">Answer Only</option>
              <option value="steps">Step-by-Step</option>
              <option value="detailed">Detailed Explanation</option>
            </select>
          </div>
        </div>
        
        <button type="submit" disabled={loading}>
          {loading ? 'Solving...' : 'Solve Problem'}
        </button>
      </form>
      
      {solution && (
        <div className="results-container">
          <div className="results-content">
            <pre>{solution}</pre>
          </div>
          
          <div className="tool-actions">
            <button onClick={() => navigator.clipboard.writeText(solution)}>
              <i className="fas fa-copy"></i> Copy
            </button>
            <button onClick={downloadSolution}>
              <i className="fas fa-download"></i> Save Solution
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
