// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed; // Cambia el tipo del argumento
  final String text;

  const Button({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // Usa la función de callback proporcionada
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(395, 55),
        primary: const Color(0xFFF8B595), // Color #F8B595
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),

      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
