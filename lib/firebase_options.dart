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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCi6qzrvcjh-su6SiaFeJQFrgtGL7yQeSQ',
    appId: '1:128789204836:web:ca630d78e5aeba4a1af471',
    messagingSenderId: '128789204836',
    projectId: 'answeralyzer',
    authDomain: 'answeralyzer.firebaseapp.com',
    storageBucket: 'answeralyzer.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAwam0QEsNrg-s5QYKB64Pk82unEmXunt0',
    appId: '1:128789204836:android:2549d9a5b7a203141af471',
    messagingSenderId: '128789204836',
    projectId: 'answeralyzer',
    storageBucket: 'answeralyzer.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAkk1KpWdXikuwNX4ehq1aYPe1_mg_EFZ8',
    appId: '1:128789204836:ios:0b3945032dc233aa1af471',
    messagingSenderId: '128789204836',
    projectId: 'answeralyzer',
    storageBucket: 'answeralyzer.appspot.com',
    iosClientId: '128789204836-0v1skno61bm17sm65qcgfcehl478rvnr.apps.googleusercontent.com',
    iosBundleId: 'com.example.iotProject',
  );
}
