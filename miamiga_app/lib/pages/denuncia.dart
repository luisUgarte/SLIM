import 'package:flutter/material.dart';

class DenunciaScreen extends StatelessWidget {
  const DenunciaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Denuncia',
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
