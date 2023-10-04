import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {

  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final bool isEnabled;


  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.isEnabled,

  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: widget.hintText,
          enabled: widget.isEnabled,
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }
}