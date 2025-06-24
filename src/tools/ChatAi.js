import { useState, useRef } from 'react';
import { generateContent } from '../services/google-ai';
import VoiceInput from '../components/VoiceInput';
import ImageUpload from '../components/ImageUpload';

export default function ChatAI() {
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const messagesEndRef = useRef(null);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!input.trim() || isLoading) return;

    // Add user message
    const newMessages = [...messages, { role: 'user', content: input }];
    setMessages(newMessages);
    setInput('');
    setIsLoading(true);
    
    try {
      // Get AI response
      const response = await generateContent(
        input,
        "You are Keizer, a helpful AI assistant. Respond conversationally."
      );
      
      // Add AI message
      setMessages([...newMessages, { role: 'ai', content: response }]);
    } catch (error) {
      setMessages([...newMessages, { 
        role: 'ai', 
        content: "Sorry, I encountered an error. Please try again." 
      }]);
    } finally {
      setIsLoading(false);
    }
  };

  const handleVoiceResult = (text) => {
    setInput(text);
  };

  const handleImageUpload = (file) => {
    // For chat, we can send image descriptions
    setInput(`Describe this image: ${file.name}`);
  };

  return (
    <div className="tool-page">
      <div className="chat-container">
        <div className="chat-messages">
          {messages.map((msg, index) => (
            <div key={index} className={`message ${msg.role}`}>
              {msg.content}
            </div>
          ))}
          {isLoading && (
            <div className="message ai">
              <div className="typing-indicator">
                <span></span><span></span><span></span>
              </div>
            </div>
          )}
          <div ref={messagesEndRef} />
        </div>
        
        <form className="chat-input-container" onSubmit={handleSubmit}>
          <div className="input-group">
            <input
              type="text"
              value={input}
              onChange={(e) => setInput(e.target.value)}
              placeholder="Ask me anything..."
              autoFocus
            />
            <VoiceInput onResult={handleVoiceResult} />
            <ImageUpload onUpload={handleImageUpload} />
          </div>
          <button type="submit" disabled={isLoading}>
            <i className="fas fa-paper-plane"></i>
          </button>
        </form>
      </div>
    </div>
  );
}
