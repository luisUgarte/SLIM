// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_import, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_final_fields, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slim_web/components/menu.dart';
import 'package:slim_web/components/button.dart';
import 'package:slim_web/components/pallete.dart';
import 'package:slim_web/components/textfield.dart';
import 'package:slim_web/pages/director.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<Perfil> {
  File? _image;

  TextEditingController nombreController = TextEditingController();
  TextEditingController ciController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController correoController = TextEditingController();

  Future getImage() async {
    // Código para obtener la imagen...
  }

  void sig(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Director(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    QuerySnapshot<Map<String, dynamic>> directores =
        await FirebaseFirestore.instance.collection('directores').get();

    if (directores.docs.isNotEmpty) {
      final director = directores.docs.first;

      setState(() {
        nombreController.text = director['nombre'] ?? '';
        ciController.text = director['ci'] ?? '';
        telefonoController.text = director['telefono'] ?? '';
        correoController.text = director['correo'] ?? '';
      });
    }
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
            const SizedBox(height: 40),
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
                      hintText: 'Nombre ',
                      labelText: 'Nombre',
                      obscureText: false,
                      isEnabled: false,
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
                      isEnabled: false,
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
                      isEnabled: false,
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
                      isEnabled: false,
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
                text: 'Nuevo Director',
                onPressed: () {
                  sig(context);
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
