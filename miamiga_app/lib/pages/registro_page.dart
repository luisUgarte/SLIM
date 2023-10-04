// ignore_for_file: use_build_context_synchronously, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miamiga_app/components/headers.dart';
import 'package:miamiga_app/components/my_button.dart';
import 'package:miamiga_app/components/my_textfield.dart';
// ignore: unused_import
import 'package:miamiga_app/pages/geolocator.dart';
// ignore: unused_import
import 'package:miamiga_app/pages/map.dart';
import 'package:miamiga_app/pages/verify_email.dart';

class RegistroPage extends StatefulWidget {

  final Function()? onTap;

  const RegistroPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {

  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final fullnameController = TextEditingController();
  final identityController = TextEditingController();
  final phoneController = TextEditingController();

  void signUserUp() async {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    // Check if password is confirmed
    if (passwordController.text != confirmPassController.text) {
      Navigator.pop(context); //cerrar el dialogo en caso de error
      showErrorMsg("Las contraseñas no coinciden");
      return;
    }

    if (areFieldsEmpty()) {
      Navigator.pop(context); //cerrar el dialogo en caso de error
      showErrorMsg("Por favor, complete todos los campos");
      return;
    }

    final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    if (res.user != null) {
      //send email verification

      await res.user!.sendEmailVerification();

      await createUserDocument(
        res.user!,
        fullnameController.text.trim(),
        emailController.text.trim(),
        int.parse(identityController.text.trim()),
        int.parse(phoneController.text.trim()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cuenta creada exitosamente'),
          backgroundColor: Colors.green,
        ),
      );

      Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.pop(context);
      });

      //Navigate to the verification screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const VerifyEmail(),
        ),
      );

      
    } else {
      Navigator.pop(context); //cerrar el dialogo en caso de error
      showErrorMsg("Error al crear la cuenta. Intente nuevamente.");
    }
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context); //cerrar el dialogo en caso de error
    showErrorMsg(e.message ?? "Error desconocido");
  } catch (e) {
    Navigator.pop(context); //cerrar el dialogo en caso de error
    showErrorMsg("Error inesperado: $e");
  } 
}

bool areFieldsEmpty() {
  return emailController.text.isEmpty ||
      fullnameController.text.isEmpty ||
      identityController.text.isEmpty ||
      phoneController.text.isEmpty;
}



  void showErrorMsg(String errorMsg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMsg,
          style: const TextStyle(
            color: Colors.white,
          )
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> createUserDocument(User user, String fullName, String email, int ci, int phone) async {
    try {
      await FirebaseFirestore.instance
          .collection('registration')
          .doc(user.uid) // Use the UID as the document ID
          .set({
            'full name': fullName,
            'email': email,
            'ci': ci,
            'phone': phone,
          });
    } catch (e) {
      // ignore: avoid_print
      print('Error al crear documento del usuario: $e');
      Navigator.pop(context);
    }
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
                header: 'Registrate',
              ),

              const SizedBox(height: 50),
              //crear cuenta

              const Text(
                'Listo para crear tu cuenta!',
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

              //campo confirmar contrasena

              MyTextField(
                controller: confirmPassController,
                hintText: 'Confirmar Contraseña',
                obscureText: true,
                isEnabled: true,
              ),
              
              const SizedBox(height: 10),

              //campo nombre completo

              MyTextField(
                controller: fullnameController,
                hintText: 'Nombre Completo',
                obscureText: false,
                isEnabled: true,
              ),
              
              const SizedBox(height: 10),

              //campo CI

              MyTextField(
                controller: identityController,
                hintText: 'Carnet de Identidad',
                obscureText: false,
                isEnabled: true,
              ),
              
              const SizedBox(height: 10),

              //campo Numero de Telefono

              MyTextField(
                controller: phoneController,
                hintText: 'Telefono',
                obscureText: false,
                isEnabled: true,
              ),
              
              
              const SizedBox(height: 10),

              //seleccionar ubicacion

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const CurrentLocationScreen();
                      },
                    ),
                  );
                }, 
                child: const Text('Seleccionar Ubicacion'),
              ),
              

              const SizedBox(height: 25),       

              //boton de iniciar sesion

              MyButton(
                text: 'Registrate',
                onTap: signUserUp,
              ),
              
              const SizedBox(height: 50),       

              //ya tiene cuenta puede ir al iniciar sesion
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Ya tiene cuenta?',
                    style: TextStyle(
                      color: Color.fromRGBO(200, 198, 198, 1),
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Iniciar Sesion',
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