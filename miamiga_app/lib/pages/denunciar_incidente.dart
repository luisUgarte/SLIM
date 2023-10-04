import 'package:flutter/material.dart';
import 'package:miamiga_app/components/headers.dart';
import 'package:miamiga_app/components/my_important_btn.dart';
import 'package:miamiga_app/components/my_textfield.dart';
import 'package:miamiga_app/components/row_button.dart';
import 'package:miamiga_app/pages/datos_denunciante.dart';

class DenunciaIncidente extends StatefulWidget {
  const DenunciaIncidente({super.key});

  @override
  State<DenunciaIncidente> createState() => _DenunciaIncidenteState();
}

class _DenunciaIncidenteState extends State<DenunciaIncidente> {

  final desController = TextEditingController();
  final dateController = TextEditingController();
  final myLocationController = TextEditingController();
  final tragedyController = TextEditingController();

  void siguiente() async{
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DatosDenunciante(), 
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
                        header: 'Datos del Incidente',
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

                  Row(
                    children: [
                      RowButton(
                        onTap: cargarImagen, 
                        text: 'Cargar Imagen',
                        icon: Icons.image,
                      ),
                      const Spacer(),
                      RowButton(
                        onTap: cargarAudio, 
                        text: 'Cargar Audio',
                        icon: Icons.audio_file,
                      ),
                    ],
                  ),

                  //campo de descripcion del incidente

                  const SizedBox(height: 25),

                  MyTextField(
                    controller: desController,
                    hintText: 'Descripción del Incidente',
                    obscureText: false,
                    isEnabled: true,
                  ),

                  //campo de fecha del incidente

                  const SizedBox(height: 15),

                  MyTextField(
                    controller: dateController,
                    hintText: 'Fecha del Incidente',
                    obscureText: false,
                    isEnabled: true,
                  ),

                  //campo del usuario ubicacion

                  const SizedBox(height: 15),

                  MyTextField(
                    controller: myLocationController,
                    hintText: 'Ubicacion del Usuario',
                    obscureText: false,
                    isEnabled: true,
                  ),

                  //campo de tipo de incidente

                  const SizedBox(height: 15),

                  MyTextField(
                    controller: tragedyController,
                    hintText: 'Tipo de Incidente',
                    obscureText: false,
                    isEnabled: true,
                  ),
                  
                  //boton de siguiente

                  const SizedBox(height: 25),

                  MyImportantBtn(
                    onTap: siguiente, 
                    text: 'Siguiente',
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