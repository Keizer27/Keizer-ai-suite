import { useState, useEffect } from 'react';
import { auth } from './auth/firebase';
import { onAuthStateChanged, signOut } from 'firebase/auth';
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
import EmailResponder from './tools/EmailResponder';
import SocialMedia from './tools/SocialMedia';
import './styles.css';

function App() {
  const [user, setUser] = useState(null);
  const [activeTool, setActiveTool] = useState('chat');
  const [sidebarOpen, setSidebarOpen] = useState(true);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, (user) => {
      setUser(user);
      setLoading(false);
    });
    return () => unsubscribe();
  }, []);

  const handleLogout = async () => {
    try {
      await signOut(auth);
    } catch (error) {
      console.error('Logout error:', error);
    }
  };

  if (loading) {
    return (
      <div className="loading-screen">
        <div className="loading-spinner">
          <i className="fas fa-spinner fa-spin"></i>
        </div>
        <p>Loading Keizer AI...</p>
      </div>
    );
  }

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
        <div className="user-actions">
          <div className="user-info">
            <i className="fas fa-user-circle"></i>
            <span>{user.email}</span>
          </div>
          <button className="logout-btn" onClick={handleLogout}>
            <i className="fas fa-sign-out-alt"></i> Logout
          </button>
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
        {activeTool === 'email' && <EmailResponder />}
        {activeTool === 'social' && <SocialMedia />}
      </main>
    </div>
  );
}

export default App;
