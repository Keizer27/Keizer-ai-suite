const API_KEY = 'AIzaSyCZ4Uj--CRx0HzktFJjn4DV-xXRPX28t-g';

export const generateContent = async (prompt, context = '') => {
  const response = await fetch(
    `https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${API_KEY}`,
    {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        contents: [{
          parts: [{ text: `${context}\n\n${prompt}` }]
        }]
      })
    }
  );
  
  if (!response.ok) throw new Error('API request failed');
  return (await response.json()).candidates[0].content.parts[0].text;
};
