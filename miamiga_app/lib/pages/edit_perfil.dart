<<<<<<< HEAD
=======
// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
>>>>>>> origin/johan
import 'package:flutter/material.dart';
import 'package:miamiga_app/components/headers.dart';
import 'package:miamiga_app/components/my_button.dart';
import 'package:miamiga_app/components/my_textfield.dart';

class EditPerfil extends StatefulWidget {
<<<<<<< HEAD
  const EditPerfil({super.key});
=======
  final User? user;

  const EditPerfil({
    super.key,
    required this.user,
  });
>>>>>>> origin/johan

  @override
  State<EditPerfil> createState() => _EditPerfilState();
}

class _EditPerfilState extends State<EditPerfil> {

  final fullnameController = TextEditingController();
  final phoneController = TextEditingController();
<<<<<<< HEAD
  final locationController = TextEditingController();

  void savePerfil () async{

  }
=======
  final ciController = TextEditingController();
  
  final CollectionReference _registration = 
        FirebaseFirestore.instance.collection('registration');

  //update operation
  Future<void> _updateData(String userId, String fullName, int ci, int phone) async {
  try {
    // Get a reference to the Firestore collection
    final DocumentReference userDocument = _registration.doc(userId);

    // Update the document with the specified userId
    await userDocument.update({
      'full name': fullName,
      'ci': ci,
      'phone': phone,
    });

    print('Actualizado exitoso de datos!');
  } catch (e) {
    print('Error actualizando datos: $e');
  }
}

  //i want to fetch data from firebase and show it in the textfields

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

>>>>>>> origin/johan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //safearea avoids the notch area
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
   
<<<<<<< HEAD
              Row(
                children: [
                  const Header(
                    header: 'Editar Perfil',
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),

              const SizedBox(height: 25),
              
              //campo nombre completo
              
              MyTextField(
                controller: fullnameController,
                hintText: 'Nombre Completo',
                obscureText: false,
                isEnabled: true,
              ),

              const SizedBox(height: 10),

              //campo telefono
              
              MyTextField(
                controller: phoneController,
                hintText: 'Telefono',
                obscureText: false,
                isEnabled: true,
              ),

              const SizedBox(height: 10),

              //campo ubicacion
              
              MyTextField(
                controller: locationController,
                hintText: 'Ubicacion',
                obscureText: false,
                isEnabled: true,
              ),

              const SizedBox(height: 25),

              //boton de iniciar sesion

              MyButton(
                text: 'GUARDAR DATOS PERSONALES',
                onTap: savePerfil,
=======
                  Row(
                    children: [
                      const Header(
                        header: 'Editar Perfil',
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
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
                          isEnabled: true,
                        ),
                        const SizedBox(height: 15),
                        MyTextField(
                          controller: ciController,
                          hintText: 'CI',
                          obscureText: false,
                          isEnabled: true,
                        ),
                        const SizedBox(height: 15),
                        MyTextField(
                          controller: phoneController,
                          hintText: 'Telefono',
                          obscureText: false,
                          isEnabled: true,
                        ),
                        const SizedBox(height: 25),

                        MyButton(
                          onTap: () {
                            _updateData(
                              widget.user!.uid, 
                              fullnameController.text, 
                              int.parse(ciController.text), 
                              int.parse(phoneController.text)
                            );
                          }, 
                          text: 'Actualizar'
                        ),

                      ],
                    );
                  }
                }
>>>>>>> origin/johan
              ),
            ],
          ),
        ),
      ),
    );
  }
}