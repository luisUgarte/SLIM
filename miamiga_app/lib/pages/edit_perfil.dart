import 'package:flutter/material.dart';
import 'package:miamiga_app/components/headers.dart';
import 'package:miamiga_app/components/my_button.dart';
import 'package:miamiga_app/components/my_textfield.dart';

class EditPerfil extends StatefulWidget {
  const EditPerfil({super.key});

  @override
  State<EditPerfil> createState() => _EditPerfilState();
}

class _EditPerfilState extends State<EditPerfil> {

  final fullnameController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();

  void savePerfil () async{

  }

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
              ),
            ],
          ),
        ),
      ),
    );
  }
}