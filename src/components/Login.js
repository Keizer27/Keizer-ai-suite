import { useState } from 'react';
import { auth } from '../auth/firebase';
import { createUserWithEmailAndPassword, signInWithEmailAndPassword } from 'firebase/auth';

export default function Login() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [isLogin, setIsLogin] = useState(true);
  const [error, setError] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      if (isLogin) {
        await signInWithEmailAndPassword(auth, email, password);
      } else {
        await createUserWithEmailAndPassword(auth, email, password);
      }
    } catch (err) {
      setError(err.message);
    }
  };

  return (
    <div className="login-container">
      <div className="login-card">
        <img src="/assets/keizer-logo.svg" alt="Keizer AI" className="logo" />
        <h2>{isLogin ? 'Login to Keizer AI' : 'Create Account'}</h2>
        
        {error && <div className="error-message">{error}</div>}
        
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label>Email</label>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
          </div>
          
          <div className="form-group">
            <label>Password</label>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
          </div>
          
          <button type="submit" className="primary-btn">
            {isLogin ? 'Login' : 'Sign Up'}
          </button>
        </form>
        
        <button 
          className="toggle-btn"
          onClick={() => setIsLogin(!isLogin)}
        >
          {isLogin 
            ? 'Need an account? Sign up' 
            : 'Already have an account? Login'}
        </button>
      </div>
    </div>
  );
}
