import React from 'react';

const tools = [
  { id: 'chat', name: 'AI Chat', icon: 'fa-comment-dots' },
  { id: 'research', name: 'Research Assistant', icon: 'fa-search' },
  { id: 'article', name: 'Article Writer', icon: 'fa-newspaper' },
  { id: 'resume', name: 'Resume Writer', icon: 'fa-file-contract' },
  { id: 'image', name: 'Image Editor', icon: 'fa-image' },
  { id: 'math', name: 'Math Solver', icon: 'fa-square-root-alt' },
  { id: 'script', name: 'Script Writer', icon: 'fa-scroll' },
  { id: 'content', name: 'Content Creator', icon: 'fa-pencil-alt' },
  { id: 'email', name: 'Email Responder', icon: 'fa-envelope' },
  { id: 'social', name: 'Social Media', icon: 'fa-share-alt' },
];

export default function Sidebar({ open, onSelectTool, currentTool }) {
  return (
    <aside className={`sidebar ${open ? 'open' : ''}`}>
      <div className="tools-header">
        <h3>AI Tools</h3>
      </div>
      
      <div className="tools-list">
        {tools.map(tool => (
          <button
            key={tool.id}
            className={`tool-item ${currentTool === tool.id ? 'active' : ''}`}
            onClick={() => onSelectTool(tool.id)}
          >
            <i className={`fas ${tool.icon}`}></i>
            <span>{tool.name}</span>
          </button>
        ))}
      </div>
    </aside>
  );
}
