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
    apiKey: 'AIzaSyBYz7E5XTIcYEAnf10ShXdB5-kHlao0PkQ',
    appId: '1:499700648315:web:123c44d2e69b5f5f39d5de',
    messagingSenderId: '499700648315',
    projectId: 'tourism-cf844',
    authDomain: 'tourism-cf844.firebaseapp.com',
    storageBucket: 'tourism-cf844.appspot.com',
    measurementId: 'G-YFWQYG6T98',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfPwzNdJs7DgUbWg2ITS-_IyfqIOSiu6I',
    appId: '1:499700648315:android:7b836d75bd1e67b139d5de',
    messagingSenderId: '499700648315',
    projectId: 'tourism-cf844',
    storageBucket: 'tourism-cf844.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOVhD-L5lMmHsrg_17tnl1fjlWFgxDYCM',
    appId: '1:499700648315:ios:6e5aca42b3ffa25d39d5de',
    messagingSenderId: '499700648315',
    projectId: 'tourism-cf844',
    storageBucket: 'tourism-cf844.appspot.com',
    iosClientId: '499700648315-b9ltdnp7m06g9j610d9taivdi7kkcv71.apps.googleusercontent.com',
    iosBundleId: 'com.example.tourism',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDOVhD-L5lMmHsrg_17tnl1fjlWFgxDYCM',
    appId: '1:499700648315:ios:6e5aca42b3ffa25d39d5de',
    messagingSenderId: '499700648315',
    projectId: 'tourism-cf844',
    storageBucket: 'tourism-cf844.appspot.com',
    iosClientId: '499700648315-b9ltdnp7m06g9j610d9taivdi7kkcv71.apps.googleusercontent.com',
    iosBundleId: 'com.example.tourism',
  );
}
