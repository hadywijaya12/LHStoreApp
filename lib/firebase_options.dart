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
    apiKey: 'AIzaSyA00_Kf_HCVEbL9_MMp-acyi7l6EF-isWM',
    appId: '1:497674009483:web:d8430573b2d64ffadccd8e',
    messagingSenderId: '497674009483',
    projectId: 'lhstore-80597',
    authDomain: 'lhstore-80597.firebaseapp.com',
    storageBucket: 'lhstore-80597.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMUQrdfF-nZP_1pmJXTnAVTWGqg0EXKlc',
    appId: '1:497674009483:android:0bb256eb87851c14dccd8e',
    messagingSenderId: '497674009483',
    projectId: 'lhstore-80597',
    storageBucket: 'lhstore-80597.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7RQGZXP13P0RyobG80PBcixnqaLyhgWs',
    appId: '1:497674009483:ios:0cde90002f9d469bdccd8e',
    messagingSenderId: '497674009483',
    projectId: 'lhstore-80597',
    storageBucket: 'lhstore-80597.appspot.com',
    iosBundleId: 'com.lhstore.lhstore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD7RQGZXP13P0RyobG80PBcixnqaLyhgWs',
    appId: '1:497674009483:ios:7a1bb7d235c55727dccd8e',
    messagingSenderId: '497674009483',
    projectId: 'lhstore-80597',
    storageBucket: 'lhstore-80597.appspot.com',
    iosBundleId: 'com.lhstore.lhstore.RunnerTests',
  );
}
