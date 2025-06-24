import { useRef } from 'react';

export default function ImageUpload({ onUpload }) {
  const fileInputRef = useRef();

  const handleClick = () => {
    fileInputRef.current.click();
  };

  const handleFileChange = (e) => {
    const file = e.target.files[0];
    if (file && onUpload) {
      onUpload(file);
    }
  };

  return (
    <>
      <button className="image-upload-btn" onClick={handleClick}>
        <i className="fas fa-image"></i>
      </button>
      <input
        type="file"
        ref={fileInputRef}
        accept="image/*"
        onChange={handleFileChange}
        style={{ display: 'none' }}
      />
    </>
  );
}
