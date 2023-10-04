import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: unused_import
import 'package:miamiga_app/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
<<<<<<< HEAD
import 'package:miamiga_app/pages/splash_screen.dart';
import 'firebase_options.dart';
=======
import 'firebase_options.dart';
import 'package:miamiga_app/pages/splash_screen.dart';
>>>>>>> origin/johan

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
<<<<<<< HEAD
    options: DefaultFirebaseOptions.currentPlatform
  );
=======
  options: DefaultFirebaseOptions.currentPlatform,
);
>>>>>>> origin/johan

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Miamiga',
      home: SplashScreen(),
    );
  }
}






