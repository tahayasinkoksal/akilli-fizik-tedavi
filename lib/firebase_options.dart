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
    apiKey: 'KEY-DELETE',
    appId: '1:895270264279:android:247647905377fcc88dbf92',
    messagingSenderId: '895270264279',
    projectId: 'diyetasistani-c1740',
    databaseURL: 'https://diyetasistani-c1740-default-rtdb.firebaseio.com',
    storageBucket: 'diyetasistani-c1740.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'KEY-DELETE',
    appId: '1:895270264279:ios:2f6bb51a9dc040448dbf92',
    messagingSenderId: '895270264279',
    projectId: 'diyetasistani-c1740',
    databaseURL: 'https://diyetasistani-c1740-default-rtdb.firebaseio.com',
    storageBucket: 'diyetasistani-c1740.appspot.com',
    androidClientId: '895270264279-t60gdeh1mm0uc7s94t4ubv21m5th0sno.apps.googleusercontent.com',
    iosClientId: '895270264279-blamsrb1ondnm3ftlks78a2hd9oaaqv2.apps.googleusercontent.com',
    iosBundleId: 'com.tahayasinkoksal.fiziktedavi.bitirmeProjesiFizikTedavi',
  );

}