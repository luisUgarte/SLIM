// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:miamiga_app/components/headers.dart';
import 'package:miamiga_app/components/my_button.dart';
import 'package:miamiga_app/components/my_textfield.dart';// ignore: unused_import
import 'package:miamiga_app/pages/edit_perfil.dart';
import 'package:miamiga_app/pages/inicio_o_registrar.dart';

class PerfilScreen extends StatefulWidget {
  final User? user;

  const PerfilScreen({super.key, required this.user});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {

  final fullnameController = TextEditingController();
  final phoneController = TextEditingController();
  final ciController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void signUserOut(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LoginOrRegister(),
      ),
    );
  }

  void editPersonalData() async{
    //i want a navigator to go to the edit perfil page
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditPerfil(user: widget.user), 
      ),
    );
  }

  final CollectionReference _registration = 
        FirebaseFirestore.instance.collection('registration');

  Future<void> _fetchData() async {
  try {
    // Check if widget.user is not null before proceeding
    if (widget.user != null) {
      final DocumentSnapshot documentSnapshot =
          await _registration.doc(widget.user!.uid).get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        fullnameController.text = documentSnapshot['full name'];
        phoneController.text = documentSnapshot['phone'].toString();
        ciController.text = documentSnapshot['ci'].toString();
      } else {
        // Handle the case where the document doesn't exist
        print("No existe el documento.");
      }
    } else {
      // Handle the case where widget.user is null
      print("El usuario es nulo.");
    }
  } catch (e) {
    // Handle any other errors that may occur during data retrieval
    print("Error en obtener datos: $e");
  }
}

@override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack( // Wrap the content with a Stack
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const SizedBox(height: 15),
                  

                  Row(
                    children: [
                      const Header(
                        header: 'Mi Perfil',
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () {
                          _showSignOutConfirmationDialog(context);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),


                  FutureBuilder(
                  future: _fetchData(), 
                  builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text ('Error: ${snapshot.error}');
                  } else {
                    return Column(
                      children: [
                        const SizedBox(height: 25),
                        MyTextField(
                          controller: fullnameController,
                          hintText: 'Nombre Completo',
                          obscureText: false,
                          isEnabled: false,
                        ),
                        const SizedBox(height: 15),
                        MyTextField(
                          controller: ciController,
                          hintText: 'CI',
                          obscureText: false,
                          isEnabled: false,
                        ),
                        const SizedBox(height: 15),
                        MyTextField(
                          controller: phoneController,
                          hintText: 'Telefono',
                          obscureText: false,
                          isEnabled: false,
                        ),
                        const SizedBox(height: 15),
                        MyButton(
                          onTap: editPersonalData, 
                          text: 'Editar Perfil'
                        )
                      ],
                    );
                  }
                }
              ),

                  const SizedBox(height: 70),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      widget.user != null ? 'Iniciado como: ${widget.user?.email}' : 'Usuario desconocido',
                      style: const TextStyle(fontSize: 20),
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




  // Function to show the sign-out confirmation dialog
void _showSignOutConfirmationDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Cierre de Sesión'),
          content: const Text('¿Estás seguro de que deseas cerrar la sesión?'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Perform sign-out action here
                signUserOut(context); // Call your sign-out method
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar Sesión'),
            ),
          ],
        );
      },
    );
  }
}