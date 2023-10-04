// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miamiga_app/components/headers.dart';
import 'package:miamiga_app/components/my_button.dart';
import 'package:miamiga_app/components/my_textfield.dart';
import 'package:miamiga_app/components/square_tile.dart';
import 'package:miamiga_app/pages/reset_pass.dart';
import 'package:miamiga_app/pages/screens.dart';
import 'package:miamiga_app/services/auth_services.dart';

class IniciarSesion extends StatefulWidget {

  final Function()? onTap;
  const IniciarSesion({
    super.key,
    required this.onTap,
  });

  @override
  State<IniciarSesion> createState() => _IniciarSesionState();
}

class _IniciarSesionState extends State<IniciarSesion> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Map<String, String> errorMessages = {
    'invalid-email': 'Correo electrónico inválido',
    'user-not-found': 'Usuario no encontrado',
    'wrong-password': 'Contraseña incorrecto',
    'email-password': 'Correo o Contraseña incorrectos'
  };

  //sign in method
  void signInUser() async{

    //mostrar un carga de inicio
    showDialog(context: context, builder: (context){
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

    try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text,
      );
      //quitar el dialogo de carga
      Navigator.pop(context);
      //ir a la pantalla de inicio
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Screens(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      //quitar el dialogo de carga
      Navigator.pop(context);
      //mostar mensaje de error
      showErrorMsg(e.code);
    }
  }

    void showErrorMsg(String errorCode) {
      String errorMessage = errorMessages[errorCode] ?? 'Error desconocido';

      showDialog(
        context: context, 
        builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.pink,
          title: Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //safearea avoids the notch area
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              
              const Header(
                header: 'Iniciar Sesion',
              ),

              const SizedBox(height: 50),
              //bienvenido

              const Text(
                'Bienvenido usuari@ te hemos extrañado',
                style: TextStyle(
                  color: Color.fromRGBO(200, 198, 198, 1),
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),
              
              //campo usuario
              
              MyTextField(
                controller: emailController,
                hintText: 'Correo Electrónico',
                obscureText: false,
                isEnabled: true,
              ),

              const SizedBox(height: 10),

              //campo contrasena

              MyTextField(
                controller: passwordController,
                hintText: 'Contraseña',
                obscureText: true,
                isEnabled: true,
              ),
              
              const SizedBox(height: 10),

              //restablecer contrasena

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ResetPassword();
                          }
                          ),
                        );
                      },
                      child: const Text(
                        'Olvidaste tu Contraseña',
                        style: TextStyle(
                          color: Color.fromRGBO(108, 91, 124, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              //boton de iniciar sesion

              MyButton(
                text: 'Iniciar Sesion',
                onTap: signInUser,
              ),
              
              const SizedBox(height: 50),

              //o continuar con

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
              
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'O continuar con',
                        style: TextStyle(
                          color: Color.fromRGBO(200, 198, 198, 1),
                        ),
                      ),
                    ),
              
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 50),

              //google 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google button
                  SquareTile(
                    imgPath: 'lib/images/google.png',
                    onTap: () {
                      final authService = AuthService(context: context);
                      authService.signInWithGoogle();
                    }
                  ),
                ],
              ),

              const SizedBox(height: 50),

              //aun no tiene cuenta debe registrarse
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Aun no tiene cuenta?',
                    style: TextStyle(
                      color: Color.fromRGBO(200, 198, 198, 1),
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Registrate',
                      style: TextStyle(
                        color: Color.fromRGBO(108, 91, 124, 1), 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}