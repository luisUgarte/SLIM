// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_import, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_final_fields, deprecated_member_use, use_build_context_synchronously, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slim_web/components/Menu.dart';
import 'package:slim_web/components/button.dart';
import 'package:slim_web/components/pallete.dart';
import 'package:slim_web/components/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slim_web/pages/perfil.dart';

class Director extends StatefulWidget {
  @override
  _DirectorState createState() => _DirectorState();
}

class _DirectorState extends State<Director> {
  File? _image;

  TextEditingController nombreController = TextEditingController();
  TextEditingController ciController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController contraseniaController = TextEditingController();

  Future getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> registrarDirectorEnFirebase() async {
    // Leer los datos de los campos de texto
    String nombre = nombreController.text;
    String ci = ciController.text;
    String telefono = telefonoController.text;
    String correo = correoController.text;
    String contrasenia = contraseniaController.text;

    try {
      // Registrar al director en Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: correo,
        password: contrasenia,
      );

      // Obtener el ID del usuario registrado
      String userId = userCredential.user!.uid;

      // Crear un mapa para almacenar los datos del director
      Map<String, dynamic> userData = {
        'nombre': nombre,
        'ci': ci,
        'telefono': telefono,
        'correo': correo,
        'contrasenia': contrasenia,
      };

      // Guardar los datos en Firestore bajo una colección llamada 'directores'
      await FirebaseFirestore.instance
          .collection('directores')
          .doc(userId)
          .set(userData);

      // Navegar a la siguiente pantalla, por ejemplo, Perfil
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Perfil()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // El correo electrónico ya está en uso, manejar de acuerdo a tus necesidades.
        print('El correo electrónico ya está en uso');
      }
    } catch (error) {
      print("Error al registrar el director: $error");
    }
  }

  // Método para validar el nombre
  String? validateCI(String? value) {
    final RegExp ciExp = RegExp(r"^[0-9]+$");
    if (value == null || value.isEmpty || !ciExp.hasMatch(value)) {
      return 'Ingresa un CI válido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Amiga'),
        backgroundColor: Pallete.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Nuevo Director',
                      style: TextStyle(
                        color: Color(0xFFD15A7C),
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                    height:
                        20), // Espacio entre el título y los campos de texto
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: getImage,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 110),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: SizedBox(
                            width: 160,
                            height: 160,
                            child: _image != null
                                ? Image.file(
                                    _image!,
                                    width: 160,
                                    height: 160,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'lib/images/profiles.png',
                                    width: 160,
                                    height: 160,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 110),
                    child: MyTextField(
                      controller: nombreController,
                      hintText: 'Nombre Completo',
                      labelText: 'Nombre Completo',
                      obscureText: false,
                      isEnabled: true,
                      validator: (value) {
                        final RegExp nameExp = RegExp(r"^[A-Za-z ]+$");
                        if (value == null ||
                            value.isEmpty ||
                            !nameExp.hasMatch(value)) {
                          return 'Ingresa un nombre válido';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 110,
                      right: 10,
                    ),
                    child: MyTextField(
                      controller: ciController,
                      hintText: 'CI',
                      labelText: 'CI',
                      obscureText: false,
                      isEnabled: true,
                      validator: (value) {
                        final RegExp ciExp = RegExp(r"^[0-9]+$");
                        if (value == null ||
                            value.isEmpty ||
                            !ciExp.hasMatch(value)) {
                          return 'Ingresa un CI válido';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 110,
                    ),
                    child: MyTextField(
                      controller: telefonoController,
                      hintText: 'Telefono',
                      labelText: 'Telefono',
                      obscureText: false,
                      isEnabled: true,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 110),
                    child: MyTextField(
                      controller: correoController,
                      hintText: 'Correo',
                      labelText: 'Correo',
                      obscureText: false,
                      isEnabled: true,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 110),
                    child: MyTextField(
                      controller: contraseniaController,
                      hintText: 'Contraseña',
                      labelText: 'Contraseña',
                      obscureText: true,
                      isEnabled: true,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 800,
              child: Button(
                text: 'Guardar',
                onPressed: () {
                  registrarDirectorEnFirebase();
                },
              ),
            ),
          ],
        ),
      ),
      drawer: MenuWidget(),
    );
  }
}
