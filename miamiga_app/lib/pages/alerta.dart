import 'package:flutter/material.dart';
import 'package:miamiga_app/components/important_button.dart';
import 'package:miamiga_app/components/my_button.dart';
import 'package:miamiga_app/components/my_important_btn.dart';
import 'package:miamiga_app/pages/alerta_oficial.dart';
import 'package:miamiga_app/pages/denunciar_incidente.dart';
import 'package:miamiga_app/pages/screens.dart';

class AlertaScreen extends StatefulWidget {
  
  const AlertaScreen({
    super.key,
    
  });

  @override
  State<AlertaScreen> createState() => _AlertaScreenState();
}

class _AlertaScreenState extends State<AlertaScreen> {

  void editarDenuncia() async{
    //i want a navigator to go to the edit perfil page
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DenunciaIncidente(), 
      ),
    );
  }

  void alert() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('¿Estás seguro?'),
          content: const Text('¿Deseas denunciar este incidente?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AlertaOficialScreen(), 
                  ),
                );
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void homeScreen() async {
    //i want a navigator to go to the home screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Screens(), 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
                Center(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          '¿Estás seguro de proceder hacer un alerta?',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.start,
                        ),
                      ),    
                      const SizedBox(height: 50),
                      MyImportantBtn(
                        text: 'Editar',
                        onTap: editarDenuncia,
                      ),

                      const SizedBox(height: 50),
                      ImportantButton(
                        text: 'ALERTA',
                        onTap: alert,
                        icon: Icons.warning_rounded,
                    ),

                    const SizedBox(height: 50),
                      MyButton(
                        text: 'Ir al Inicio',
                        onTap: homeScreen,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}