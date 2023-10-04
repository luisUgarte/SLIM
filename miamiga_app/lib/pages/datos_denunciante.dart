import 'package:flutter/material.dart';
import 'package:miamiga_app/components/headers.dart';
import 'package:miamiga_app/components/my_important_btn.dart';
import 'package:miamiga_app/components/my_textfield.dart';
import 'package:miamiga_app/pages/alerta.dart';

class DatosDenunciante extends StatefulWidget {
  const DatosDenunciante({super.key});

  @override
  State<DatosDenunciante> createState() => _DatosDenuncianteState();
}

class _DatosDenuncianteState extends State<DatosDenunciante> {

  final fullnameController = TextEditingController();
  final ciController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();

  void denunciar() async{
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AlertaScreen(), 
      ),
    );
  }

  void cargarImagen() async{
    
  }

  void cargarAudio() async{
    
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
                        header: 'Datos del Denunciante',
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

                  // dos botones para subir imagen y audio del incidente en una

                  const SizedBox(height: 25),

                  MyTextField(
                    controller: fullnameController,
                    hintText: 'Nombre Completo',
                    obscureText: false,
                    isEnabled: true,
                  ),

                  //campo de fecha del incidente

                  const SizedBox(height: 15),

                  MyTextField(
                    controller: ciController,
                    hintText: 'Carnet de Identidad',
                    obscureText: false,
                    isEnabled: true,
                  ),

                  //campo del usuario ubicacion

                  const SizedBox(height: 15),

                  MyTextField(
                    controller: phoneController,
                    hintText: 'Telefono',
                    obscureText: false,
                    isEnabled: true,
                  ),

                  //campo de tipo de incidente

                  const SizedBox(height: 15),

                  MyTextField(
                    controller: locationController,
                    hintText: 'Ubicacion',
                    obscureText: false,
                    isEnabled: true,
                  ),
                  
                  //boton de siguiente

                  const SizedBox(height: 25),
                  
                  MyImportantBtn(
                    onTap: denunciar, 
                    text: 'Denunciar',
                  )
                

                
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}