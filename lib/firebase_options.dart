// import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
// import 'package:flutter/foundation.dart'
//     show kIsWeb, TargetPlatform, defaultTargetPlatform;

// /// Default [FirebaseOptions] for use with your Firebase apps.
// ///
// /// Example:
// /// ```dart
// /// import 'firebase_options.dart';
// /// // ...
// /// await Firebase.initializeApp(
// ///   options: DefaultFirebaseOptions.currentPlatform,
// /// );
// /// ```
// class DefaultFirebaseOptions {
//   static FirebaseOptions get currentPlatform {
//     if (kIsWeb) {
//       throw UnsupportedError(
//         'DefaultFirebaseOptions have not been configured for web - '
//         'you can reconfigure this by running the FlutterFire CLI again.',
//       );
//     }
//     switch (defaultTargetPlatform) {
//       case TargetPlatform.android:
//         return android;
//       case TargetPlatform.iOS:
//         return ios;
//       case TargetPlatform.macOS:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for macOS - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.windows:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for windows - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.linux:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for linux - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       default:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions are not supported for this platform.',
//         );
//     }
//   }

//   static const FirebaseOptions android = FirebaseOptions(
//     apiKey: 'AIzaSyCpUpuP8fonj4tDX5Jx8oo0z6WN668k0kQ',
//     appId: '1:288842837392:android:1353619813061d867a5715',
//     messagingSenderId: '288842837392',
//     projectId: 'com.example.chatapp',
//     storageBucket: 'com.example.chatapp.appspot.com',
//   );

//   static const FirebaseOptions ios = FirebaseOptions(
//     apiKey: 'AIzaSyCpUpuP8fonj4tDX5Jx8oo0z6WN668k0kQ',
//     appId: '1:288842837392:android:1353619813061d867a5715',
//     messagingSenderId: '288842837392',
//     projectId: 'com.example.chatapp',
//     storageBucket: 'com.example.chatapp.appspot.com',
//     androidClientId:
//         '288842837392-gvt1l790g0t1fmnurc5pmko3oss8b1tq.apps