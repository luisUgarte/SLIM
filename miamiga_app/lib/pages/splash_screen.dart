import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: unused_import
import 'package:miamiga_app/pages/inicio.dart';
import 'package:miamiga_app/pages/inicio_o_registrar.dart';
import 'package:miamiga_app/pages/screens.dart';
import 'package:miamiga_app/services/logged_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
  with SingleTickerProviderStateMixin {

    bool isLoading = true;

    @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 3), () async{
      final isLoggedIn = await checkUserLoggedIn();

      setState(() {
        isLoading = false;
      });

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => 
          isLoggedIn ? const Screens() : const LoginOrRegister(),
      ));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, 
    overlays: SystemUiOverlay.values);
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color.fromRGBO(209, 90, 124, 1), Color.fromRGBO(108, 91, 124, 1)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/images/logo.png',
              width: 60,
              height: 60,
            ),
            const SizedBox(height: 20),
            const Text(
              'Miamiga', 
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.white,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 70),
            //mostrar el progreso de carga si isLoading es true
            isLoading 
            ? const CupertinoActivityIndicator(
              color: Colors.white,
              radius: 18,
            ) 
            : Container(),
          ],
        ),
      ),
    );
  }
}