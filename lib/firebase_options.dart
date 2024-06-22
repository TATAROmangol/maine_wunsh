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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1e-da4ZM27j7LFEEc2ddzcO7JYzHlacU',
    appId: '1:342517645041:android:5d7af1f8006d1206e7f350',
    messagingSenderId: '342517645041',
    projectId: 'maineapp-438a7',
    storageBucket: 'maineapp-438a7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBWWq8P2d1ku01XnYA47LIEUdxtjyT03Qg',
    appId: '1:342517645041:ios:a7e59a110a3b2d1fe7f350',
    messagingSenderId: '342517645041',
    projectId: 'maineapp-438a7',
    storageBucket: 'maineapp-438a7.appspot.com',
    androidClientId: '342517645041-0hbk429vsrbant925tmese3c7k59k350.apps.googleusercontent.com',
    iosClientId: '342517645041-7ku30urfaqho8t5r033ogal8sqh13o6j.apps.googleusercontent.com',
    iosBundleId: 'com.example.maineApp',
  );

}