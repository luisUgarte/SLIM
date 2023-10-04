import 'package:flutter/material.dart';
import 'package:miamiga_app/components/headers.dart';
import 'package:miamiga_app/components/my_button.dart';
import 'package:miamiga_app/components/my_textfield.dart';

class EditName extends StatefulWidget {
  const EditName({super.key});

  @override
  State<EditName> createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {

  final fullnameController = TextEditingController();

  void saveName () async{

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
                    header: 'Editar Nombre Completo',
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
                controller: fullnameController, 
                hintText: 'Nombre Completo', 
                obscureText: false, 
                isEnabled: true,
              ),

              const SizedBox(height: 25),

              MyButton(
                onTap: saveName, 
                text: 'GUARDAR',
              ),
            ],
          ),
        )
      ),
    );
  }
}