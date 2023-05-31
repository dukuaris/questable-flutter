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
    apiKey: 'AIzaSyBUp9hcM52Csyj4uMNz7G8YE7yFdQMaPLo',
    appId: '1:65682280200:web:b3d7aecd79624558fb26bd',
    messagingSenderId: '65682280200',
    projectId: 'questable-data-60074',
    authDomain: 'questable-data-60074.firebaseapp.com',
    storageBucket: 'questable-data-60074.appspot.com',
    measurementId: 'G-3ZV4QHFN07',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAAjU0-CEohX0Hb41P3rNLiptJlQiCj2yY',
    appId: '1:65682280200:android:858c001f25a74923fb26bd',
    messagingSenderId: '65682280200',
    projectId: 'questable-data-60074',
    storageBucket: 'questable-data-60074.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAPAcnIdG4V9VHhqNphaVHGJ1hUKGLXCOI',
    appId: '1:65682280200:ios:5565339620943fb9fb26bd',
    messagingSenderId: '65682280200',
    projectId: 'questable-data-60074',
    storageBucket: 'questable-data-60074.appspot.com',
    iosClientId: '65682280200-p6mf7adl13udko1k4h7d4e3tps5nhjbk.apps.googleusercontent.com',
    iosBundleId: 'com.example.questableQuizFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAPAcnIdG4V9VHhqNphaVHGJ1hUKGLXCOI',
    appId: '1:65682280200:ios:1fd00fb8ca81488dfb26bd',
    messagingSenderId: '65682280200',
    projectId: 'questable-data-60074',
    storageBucket: 'questable-data-60074.appspot.com',
    iosClientId: '65682280200-b0lklr4nclgtk11kbrnoh3hsqgeeblo2.apps.googleusercontent.com',
    iosBundleId: 'com.example.questableQuizFlutter.RunnerTests',
  );
}
