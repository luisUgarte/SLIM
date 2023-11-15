// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:slim_web/components/menu.dart';
import 'package:slim_web/components/pallete.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Amiga'),
        backgroundColor: Pallete.pink,
      ),
      body: Center(
        child: Text('Contenido de la página Dashboard'),
      ),
      drawer: MenuWidget(), // Usa el widget MenuWidget
    );
  }
}
