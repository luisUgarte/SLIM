// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:slim_web/components/pallete.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final bool isEnabled;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator; // El validador para el campo

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.isEnabled,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator, // Agrega el validador al constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(27),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isEnabled ? Pallete.borderColor : Colors.grey,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        obscureText: obscureText,
        enabled: isEnabled,
        keyboardType: TextInputType.number,
        validator: validator, // Asigna el validador al campo
      ),
    );
  }
}
