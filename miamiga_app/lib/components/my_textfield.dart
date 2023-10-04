import 'package:flutter/material.dart';

<<<<<<< HEAD
class MyTextField extends StatelessWidget {
=======
class MyTextField extends StatefulWidget {
>>>>>>> origin/johan

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
<<<<<<< HEAD
  });

  @override
=======

  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  void initState() {
    super.initState();
  }

  @override
>>>>>>> origin/johan
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
<<<<<<< HEAD
        controller: controller,
        obscureText: obscureText,
=======
        controller: widget.controller,
        obscureText: widget.obscureText,
>>>>>>> origin/johan
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade100,
          filled: true,
<<<<<<< HEAD
          hintText: hintText,
          enabled: isEnabled,
          hintStyle: TextStyle(color: Colors.grey[400])
=======
          hintText: widget.hintText,
          enabled: widget.isEnabled,
          hintStyle: TextStyle(color: Colors.grey[400]),
>>>>>>> origin/johan
        ),
      ),
    );
  }
}