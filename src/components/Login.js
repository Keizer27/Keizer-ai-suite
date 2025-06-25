import { useState, useEffect } from 'react';
import { signUp, signIn, getCurrentUser } from '../auth/auth';

export default function Login() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [isLogin, setIsLogin] = useState(true);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    const checkAuth = async () => {
      try {
        const user = await getCurrentUser();
        if (user) {
          // User is already logged in
          window.location.reload();
        }
      } catch (error) {
        console.error('Auth check error:', error);
      }
    };
    
    checkAuth();
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError('');
    
    try {
      if (isLogin) {
        await signIn(email, password);
      } else {
        await signUp(email, password);
      }
      // Redirect handled by auth state change
    } catch (error) {
      setError(getFirebaseError(error.code));
    } finally {
      setLoading(false);
    }
  };

  const getFirebaseError = (code) => {
    switch(code) {
      case 'auth/invalid-email':
        return 'Please enter a valid email address';
      case 'auth/user-disabled':
        return 'This account has been disabled';
      case 'auth/user-not-found':
        return 'No account found with this email';
      case 'auth/wrong-password':
        return 'Incorrect password';
      case 'auth/email-already-in-use':
        return 'Email is already in use';
      case 'auth/weak-password':
        return 'Password should be at least 6 characters';
      default:
        return 'An error occurred. Please try again.';
    }
  };

  return (
    <div className="login-container">
      <div className="login-card">
        <div className="logo-container">
          <img src="/assets/keizer-logo.svg" alt="Keizer AI" className="logo" />
          <h2>Keizer AI</h2>
        </div>
        
        {error && <div className="error-message">{error}</div>}
        
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label>Email</label>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
              disabled={loading}
            />
          </div>
          
          <div className="form-group">
            <label>Password</label>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
              minLength={6}
              disabled={loading}
            />
          </div>
          
          <button 
            type="submit" 
            className="primary-btn"
            disabled={loading}
          >
            {loading ? (
              <span>
                <i className="fas fa-spinner fa-spin"></i> Processing...
              </span>
            ) : isLogin ? 'Login' : 'Sign Up'}
          </button>
        </form>
        
        <button 
          className="toggle-btn"
          onClick={() => setIsLogin(!isLogin)}
          disabled={loading}
        >
          {isLogin 
            ? 'Need an account? Sign up' 
            : 'Already have an account? Login'}
        </button>
      </div>
    </div>
  );
}
