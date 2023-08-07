// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBj3J71lExJNneYmyHlrwJjnXwfYdPX7Lo',
    appId: '1:335636747671:web:f634e10b22657491fbe0d2',
    messagingSenderId: '335636747671',
    projectId: 'wall-be08d',
    authDomain: 'wall-be08d.firebaseapp.com',
    storageBucket: 'wall-be08d.appspot.com',
    measurementId: 'G-YK6TDM1E93',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqbc_78ARH0HGAFi6h9RYfHr3I5hxdLxo',
    appId: '1:335636747671:android:021e38e1a5d6440ffbe0d2',
    messagingSenderId: '335636747671',
    projectId: 'wall-be08d',
    storageBucket: 'wall-be08d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwHtafteRvjfogP8GP8RQfhgUXpXrqHEc',
    appId: '1:335636747671:ios:0c0bbf774ae99bcbfbe0d2',
    messagingSenderId: '335636747671',
    projectId: 'wall-be08d',
    storageBucket: 'wall-be08d.appspot.com',
    iosClientId: '335636747671-1qiiaulckd4gu4d64h7jsn989j4ieosa.apps.googleusercontent.com',
    iosBundleId: 'com.example.wall',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDwHtafteRvjfogP8GP8RQfhgUXpXrqHEc',
    appId: '1:335636747671:ios:0c0bbf774ae99bcbfbe0d2',
    messagingSenderId: '335636747671',
    projectId: 'wall-be08d',
    storageBucket: 'wall-be08d.appspot.com',
    iosClientId: '335636747671-1qiiaulckd4gu4d64h7jsn989j4ieosa.apps.googleusercontent.com',
    iosBundleId: 'com.example.wall',
  );
}
