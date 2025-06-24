import { useState, useEffect } from 'react';
import { auth } from './auth/firebase';
import { onAuthStateChanged } from 'firebase/auth';
import Sidebar from './components/Sidebar';
import Login from './components/Login';
import ChatAI from './tools/ChatAI';
import ResearchTool from './tools/ResearchTool';
import ArticleWriter from './tools/ArticleWriter';
import ResumeWriter from './tools/ResumeWriter';
import ImageEditor from './tools/ImageEditor';
import MathSolver from './tools/MathSolver';
import ScriptWriter from './tools/ScriptWriter';
import ContentCreator from './tools/ContentCreator';
import './styles.css';

function App() {
  const [user, setUser] = useState(null);
  const [activeTool, setActiveTool] = useState('chat');
  const [sidebarOpen, setSidebarOpen] = useState(true);

  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, (user) => {
      setUser(user);
    });
    return () => unsubscribe();
  }, []);

  if (!user) return <Login />;

  return (
    <div className="app dark-mode">
      <header className="app-header">
        <button className="menu-btn" onClick={() => setSidebarOpen(!sidebarOpen)}>
          <i className="fas fa-bars"></i>
        </button>
        <div className="logo-container">
          <img src="/assets/keizer-logo.svg" alt="Keizer AI" className="logo" />
          <span>Keizer AI</span>
        </div>
      </header>

      <Sidebar 
        open={sidebarOpen} 
        onSelectTool={setActiveTool} 
        currentTool={activeTool}
      />

      <main className="tool-container">
        {activeTool === 'chat' && <ChatAI />}
        {activeTool === 'research' && <ResearchTool />}
        {activeTool === 'article' && <ArticleWriter />}
        {activeTool === 'resume' && <ResumeWriter />}
        {activeTool === 'image' && <ImageEditor />}
        {activeTool === 'math' && <MathSolver />}
        {activeTool === 'script' && <ScriptWriter />}
        {activeTool === 'content' && <ContentCreator />}
      </main>
    </div>
  );
}

export default App;
