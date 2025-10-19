# Depth.EI (MVP)

Founder: Muhammad Hashim  
Company: WealthBlueprint Technologies Group LLC  
Motto: “Defeat Debt. Unlock Wealth.”  
Brand Colors: #00FFB7 (Teal Glow), #121212 (Dark), #A7FF83 (Accent)

## Overview
- Flutter mobile app (Android & iOS)
- Firebase backend (Auth, Firestore, Cloud Functions, Hosting)
- OpenAI-powered AI Coach
- Flutterwave payments (USD/NGN/Crypto)
- Basic Admin web panel (Firebase Hosting)

## Getting Started

### 1) Requirements
- Flutter SDK
- Firebase CLI (`npm i -g firebase-tools`)
- FlutterFire CLI (`dart pub global activate flutterfire_cli`)
- Node.js 18+ for Cloud Functions

### 2) Configure Firebase
- Create Firebase project
- From `/workspace/DepthEI`, run:
  ```bash
  flutterfire configure --project <your-project-id>
  ```
  This will generate `lib/firebase_options.dart` automatically. Replace the placeholder in repo if needed.

- For web/admin panel, edit `firebase/admin_panel/index.html` firebaseConfig.
- Set environment variable for Functions (OpenAI):
  ```bash
  cd /workspace/firebase/functions
  firebase functions:config:set openai.key="YOUR_OPENAI_KEY"
  # Or set env var at deploy time: OPENAI_API_KEY=... firebase deploy --only functions
  ```

### 3) Install dependencies
```bash
cd /workspace/DepthEI
flutter pub get

cd /workspace/firebase/functions
npm install
npm run build
```

### 4) Emulators (optional)
```bash
firebase emulators:start --only functions,firestore,hosting
```

### 5) Running the app
- Open `DepthEI` in Android Studio
- Run on Android or iOS simulator / device

### 6) Deploy
```bash
cd /workspace/firebase/functions
OPENAI_API_KEY=sk-... npm run deploy

cd /workspace/firebase
firebase deploy --only hosting
```

## Notes
- Auth UI is stubbed. Hook `AuthService` into UI to enable full Firebase Auth (email/password + Google).
- Replace all `REPLACE_ME` and `REPLACE_WITH_FIREBASE_PROJECT_ID` values.
- Implement Flutterwave payments in `WalletScreen` using `flutterwave_standard`, and configure webhook URL to Functions `flutterwaveWebhook`.
- Security rules included in `firebase/firestore.rules`.
