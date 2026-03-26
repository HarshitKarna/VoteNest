// ============================================================
//  STEP 1: Paste your Firebase project config here.
//  Firebase Console → Project Settings → Your apps → SDK setup
// ============================================================
const firebaseConfig = {
  apiKey:            "YOUR_API_KEY",
  authDomain:        "YOUR_PROJECT_ID.firebaseapp.com",
  projectId:         "YOUR_PROJECT_ID",
  storageBucket:     "YOUR_PROJECT_ID.appspot.com",
  messagingSenderId: "YOUR_SENDER_ID",
  appId:             "YOUR_APP_ID"
};

// Initialise Firebase (imported as modules in each page)
// This file is just the config object — each page imports the SDKs it needs.
