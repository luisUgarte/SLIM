// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, use_build_context_synchronously, avoid_print, unused_element, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slim_web/components/button.dart';
import 'package:slim_web/components/pallete.dart';
import 'package:slim_web/components/textfield.dart';
import 'package:slim_web/pages/contrasenia.dart';
import 'package:slim_web/pages/dashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> signInWithEmailAndPassword() async {
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // El usuario ha iniciado sesión exitosamente.
        print('Inicio de sesión exitoso: ${userCredential.user?.uid}');

        // Ahora que el usuario ha iniciado sesión correctamente, navega a la página de Dashboard.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showSnackBar('Usuario no encontrado');
        } else if (e.code == 'wrong-password') {
          showSnackBar('Contraseña incorrecta');
        }
      }
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void sig(BuildContext context) {
    // Navega a la siguiente pantalla
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Contrasenia(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.asset('lib/images/logo.png'),
                    ),
                    Text(
                      'MiAmiga',
                      style: TextStyle(
                        color: Pallete.pink,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MyTextField(
                labelText: 'Correo Electrónico',
                hintText: 'Correo Electrónico',
                isEnabled: true,
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Ingresa un correo electrónico válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              MyTextField(
                labelText: 'Contraseña',
                hintText: 'Contraseña',
                isEnabled: true,
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 800,
                child: Button(
                  text: 'Iniciar Sesion',
                  onPressed: () {
                    signInWithEmailAndPassword();
                  },
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  sig(context);
                },
                child: Text('¿Olvidaste tu contraseña?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
