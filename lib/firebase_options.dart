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
    apiKey: 'AIzaSyBUKII_oWpSiJYlzf1sB255nhJaBiZIsh0',
    appId: '1:329287770834:web:d20a7dabb689ccef7f830b',
    messagingSenderId: '329287770834',
    projectId: 'smartaccessflutterapp',
    authDomain: 'smartaccessflutterapp.firebaseapp.com',
    storageBucket: 'smartaccessflutterapp.appspot.com',
    measurementId: 'G-GTXM84XVQB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJGiV4mebyITOiY_SP10Z7PM_kJ3s-Mbg',
    appId: '1:329287770834:android:daf7d4513af5baef7f830b',
    messagingSenderId: '329287770834',
    projectId: 'smartaccessflutterapp',
    storageBucket: 'smartaccessflutterapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCu-_hwZdV1l0RmCLrgTl4BDHy3Pu82yjw',
    appId: '1:329287770834:ios:b673358ce1a2899f7f830b',
    messagingSenderId: '329287770834',
    projectId: 'smartaccessflutterapp',
    storageBucket: 'smartaccessflutterapp.appspot.com',
    iosBundleId: 'com.example.smartaccessApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCu-_hwZdV1l0RmCLrgTl4BDHy3Pu82yjw',
    appId: '1:329287770834:ios:b673358ce1a2899f7f830b',
    messagingSenderId: '329287770834',
    projectId: 'smartaccessflutterapp',
    storageBucket: 'smartaccessflutterapp.appspot.com',
    iosBundleId: 'com.example.smartaccessApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBUKII_oWpSiJYlzf1sB255nhJaBiZIsh0',
    appId: '1:329287770834:web:69135a0921a718207f830b',
    messagingSenderId: '329287770834',
    projectId: 'smartaccessflutterapp',
    authDomain: 'smartaccessflutterapp.firebaseapp.com',
    storageBucket: 'smartaccessflutterapp.appspot.com',
    measurementId: 'G-4Q19XVKBFN',
  );

}