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
    apiKey: 'AIzaSyA3_Lq6k6C6pB02CXRJT7r_p02ew1T7kas',
    appId: '1:448287078983:web:9f387414d41b159eb50f62',
    messagingSenderId: '448287078983',
    projectId: 'friendlychat-29ca2',
    authDomain: 'friendlychat-29ca2.firebaseapp.com',
    storageBucket: 'friendlychat-29ca2.appspot.com',
    measurementId: 'G-HGP1W0BMZV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhPsyzh8UvchyW_bQnpLYuAFAgtp4xlZM',
    appId: '1:448287078983:android:afc8abecbfcd9cd8b50f62',
    messagingSenderId: '448287078983',
    projectId: 'friendlychat-29ca2',
    storageBucket: 'friendlychat-29ca2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBcP_UwmvOb9RmZKe9Vql7BGUEjjnaH6RA',
    appId: '1:448287078983:ios:f92b31bcf3fd36fcb50f62',
    messagingSenderId: '448287078983',
    projectId: 'friendlychat-29ca2',
    storageBucket: 'friendlychat-29ca2.appspot.com',
    iosClientId: '448287078983-614585dml83pnhksfk8mr9rka9cujct5.apps.googleusercontent.com',
    iosBundleId: 'com.example.booksyApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBcP_UwmvOb9RmZKe9Vql7BGUEjjnaH6RA',
    appId: '1:448287078983:ios:f92b31bcf3fd36fcb50f62',
    messagingSenderId: '448287078983',
    projectId: 'friendlychat-29ca2',
    storageBucket: 'friendlychat-29ca2.appspot.com',
    iosClientId: '448287078983-614585dml83pnhksfk8mr9rka9cujct5.apps.googleusercontent.com',
    iosBundleId: 'com.example.booksyApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCk0_liQtKpEYDyYFlXErnaZqjHKLWXRF0',
    appId: '1:448287078983:web:4dab2d5312e572f7b50f62',
    messagingSenderId: '448287078983',
    projectId: 'friendlychat-29ca2',
    authDomain: 'friendlychat-29ca2.firebaseapp.com',
    storageBucket: 'friendlychat-29ca2.appspot.com',
    measurementId: 'G-ZEQWM6MSXS',
  );

}