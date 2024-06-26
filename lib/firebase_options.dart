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
    apiKey: 'AIzaSyBWBYurmAqW3oCH00y3sBxXBhFICFqtxPE',
    appId: '1:143011490318:web:bb4e41fc3cfa912b20ea5f',
    messagingSenderId: '143011490318',
    projectId: 'tripit-10181',
    authDomain: 'tripit-10181.firebaseapp.com',
    storageBucket: 'tripit-10181.appspot.com',
    measurementId: 'G-79CXJ7T2CC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkgBsxFyGe5o0PEHBcrDR8G-zebvg_GdM',
    appId: '1:143011490318:android:30a34bd66671920920ea5f',
    messagingSenderId: '143011490318',
    projectId: 'tripit-10181',
    storageBucket: 'tripit-10181.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAlobXDo7L88J1Q7W7xzpYv2SpYOz9wvQU',
    appId: '1:143011490318:ios:ed58e9c4f512edf320ea5f',
    messagingSenderId: '143011490318',
    projectId: 'tripit-10181',
    storageBucket: 'tripit-10181.appspot.com',
    iosBundleId: 'com.example.tripit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAlobXDo7L88J1Q7W7xzpYv2SpYOz9wvQU',
    appId: '1:143011490318:ios:bca3c74de023248320ea5f',
    messagingSenderId: '143011490318',
    projectId: 'tripit-10181',
    storageBucket: 'tripit-10181.appspot.com',
    iosBundleId: 'com.example.tripit.RunnerTests',
  );
}
