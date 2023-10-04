import 'package:flutter/material.dart';
import 'package:miamiga_app/components/headers.dart';
import 'package:miamiga_app/components/my_button.dart';
import 'package:miamiga_app/components/my_textfield.dart';

class EditLocation extends StatefulWidget {
  const EditLocation({super.key});

  @override
  State<EditLocation> createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {

  final locationController = TextEditingController();

  void saveLocation () async{

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25),

              Row(
                children: [
                  const Header(
                    header: 'Editar Ubicacion',
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

              MyTextField(
                controller: locationController, 
                hintText: 'Ubicacion', 
                obscureText: false, 
                isEnabled: true,
              ),

              const SizedBox(height: 25),

              MyButton(
                onTap: saveLocation, 
                text: 'GUARDAR',
              ),
            ],
          ),
        )
      ),
    );
  }
}