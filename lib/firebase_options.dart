import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
if (kIsWeb) {
  throw UnsupportedError('Web is not supported for this app.');
}
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        throw UnsupportedError('Platform not supported.');
      default:
        throw UnsupportedError('Unknown platform.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAwAog0ezgVAaVJm7zMUaQvrddInqnkOYo',
    appId: '1:666706597622:web:cf59802fc8af2b9d23fed7',
    messagingSenderId: '666706597622',
    projectId: 'voicejournalapp2025',
    authDomain: 'voicejournalapp2025.firebaseapp.com',
    storageBucket: 'voicejournalapp2025.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdf9FjoF4VpCiovEHl2YZLF04XNGQ80jE',
    appId: '1:666706597622:android:d829652208656bc523fed7',
    messagingSenderId: '666706597622',
    projectId: 'voicejournalapp2025',
    storageBucket: 'voicejournalapp2025.appspot.com',
  );
}