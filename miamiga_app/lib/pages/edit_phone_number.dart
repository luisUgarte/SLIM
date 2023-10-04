import 'package:flutter/material.dart';
import 'package:miamiga_app/components/headers.dart';
import 'package:miamiga_app/components/my_button.dart';
import 'package:miamiga_app/components/my_textfield.dart';

class EditPhone extends StatefulWidget {
  const EditPhone({super.key});

  @override
  State<EditPhone> createState() => _EditPhoneState();
}

class _EditPhoneState extends State<EditPhone> {

  final phoneController = TextEditingController();

  void savePhone () async{

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
                    header: 'Editar Numero de Telefono',
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
                controller: phoneController, 
                hintText: 'Numero de Telefono', 
                obscureText: false, 
                isEnabled: true,
              ),

              const SizedBox(height: 25),

              MyButton(
                onTap: savePhone, 
                text: 'GUARDAR',
              ),
            ],
          ),
        )
      ),
    );
  }
}