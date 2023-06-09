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
    apiKey: 'AIzaSyDSaR-aSqYKpbkQVocB0w3-lVIKdYTI7J4',
    appId: '1:409072594193:android:a9cbedf8fa7dd78c50f0b0',
    messagingSenderId: '409072594193',
    projectId: 'lati-e-commece',
    storageBucket: 'lati-e-commece.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBSbyYZ2XEffYPNZEwwoYNbgz15aSappEM',
    appId: '1:409072594193:ios:c3efc6f6c157f34850f0b0',
    messagingSenderId: '409072594193',
    projectId: 'lati-e-commece',
    storageBucket: 'lati-e-commece.appspot.com',
    androidClientId: '409072594193-q65bvrc0spqh8atbghvqtmui14ls1vca.apps.googleusercontent.com',
    iosClientId: '409072594193-7scpg0dknj4npiku11g5ggugsqh3tqvt.apps.googleusercontent.com',
    iosBundleId: 'com.example.eCommerce',
  );
}
