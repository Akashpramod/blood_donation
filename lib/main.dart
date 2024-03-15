import 'package:blood_donation_app/home.dart';
import 'package:blood_donation_app/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main()async{
   WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
     await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyB2f-ch7-2trfm0Ur_2nLnQM3KOv7CondE",
  authDomain: "blood-donation-6cd7c.firebaseapp.com",
  projectId: "blood-donation-6cd7c",
  storageBucket: "blood-donation-6cd7c.appspot.com",
  messagingSenderId: "569771467318",
  appId: "1:569771467318:web:2bd701c08418c2328fae97",
  measurementId: "G-Q75R2T8F1K"
     )
     );
     } else {
    await Firebase.initializeApp();
  }

  

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context) => Splash(),
        '/login': (context) => HomePage(),
      },
    );
  }
}