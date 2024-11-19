// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD4xfcjgYbmwOmHHaL7m4rVKIl6YHp0qxM',
    appId: '1:659706374873:web:6cb7aad68fe2faec0e2cc8',
    messagingSenderId: '659706374873',
    projectId: 'final-exam-2-3590d',
    authDomain: 'final-exam-2-3590d.firebaseapp.com',
    storageBucket: 'final-exam-2-3590d.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVgKcRWIK12mMdVGOIQDiwUsSOIz39S9A',
    appId: '1:659706374873:android:08696a71a88d82580e2cc8',
    messagingSenderId: '659706374873',
    projectId: 'final-exam-2-3590d',
    storageBucket: 'final-exam-2-3590d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDKHieDs5wq5_OAvkdXuooTQhgQFbohxcI',
    appId: '1:659706374873:ios:aabd77a85dd7d48d0e2cc8',
    messagingSenderId: '659706374873',
    projectId: 'final-exam-2-3590d',
    storageBucket: 'final-exam-2-3590d.firebasestorage.app',
    iosBundleId: 'com.example.finalExam2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDKHieDs5wq5_OAvkdXuooTQhgQFbohxcI',
    appId: '1:659706374873:ios:aabd77a85dd7d48d0e2cc8',
    messagingSenderId: '659706374873',
    projectId: 'final-exam-2-3590d',
    storageBucket: 'final-exam-2-3590d.firebasestorage.app',
    iosBundleId: 'com.example.finalExam2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD4xfcjgYbmwOmHHaL7m4rVKIl6YHp0qxM',
    appId: '1:659706374873:web:45d1bc0af7d04f0c0e2cc8',
    messagingSenderId: '659706374873',
    projectId: 'final-exam-2-3590d',
    authDomain: 'final-exam-2-3590d.firebaseapp.com',
    storageBucket: 'final-exam-2-3590d.firebasestorage.app',
  );
}
