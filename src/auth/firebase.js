import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";

const firebaseConfig = {
  apiKey: "AIzaSyAawGhoA-BLIHNlobk_F3F9eflMaV8yPOw",
  authDomain: "keizer-ai.firebaseapp.com",
  projectId: "keizer-ai",
  storageBucket: "keizer-ai.appspot.com",
  messagingSenderId: "634906926507",
  appId: "keizer-ai-suite"
};

const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
