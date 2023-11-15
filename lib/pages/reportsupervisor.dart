// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, non_constant_identifier_names, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slim_web/components/button.dart';
import 'package:slim_web/components/menu.dart';
import 'package:slim_web/components/pallete.dart';
import 'package:slim_web/pages/supervisor.dart';

class ReportSupervisor extends StatefulWidget {
  @override
  _ReportSupervisorState createState() => _ReportSupervisorState();
}

class _ReportSupervisorState extends State<ReportSupervisor> {
  List<User> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUsersFromFirebase();
  }

  Future<void> getUsersFromFirebase() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('supervisor').get();

      List<User> loadedUsers = querySnapshot.docs.map((doc) {
        return User(
          doc['fullname'],
          doc['phone'],
          doc['ci'],
          doc['email'],
        );
      }).toList();

      setState(() {
        users = loadedUsers;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;    
      });
    }
  }

  void Next(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Supervisor(),
      ),
    );
  }

  Widget _buildDataTable() {
    return Container(
      margin: EdgeInsets.all(20),
      child: DataTable(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        columns: [
          DataColumn(label: Text('Nombre')),
          DataColumn(label: Text('Teléfono')),
          DataColumn(label: Text('CI')),
          DataColumn(label: Text('Correo')),
          DataColumn(label: Text('Acciones')),
        ],
        rows: users.asMap().entries.map((entry) {
          final user = entry.value;
          final color = entry.key.isEven ? Colors.white : Colors.grey[200];

          return DataRow(
            color: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return color ?? Colors.white;
              },
            ),
            cells: [
              DataCell(Text(user.name)),
              DataCell(Text(user.phone)),
              DataCell(Text(user.ci)),
              DataCell(Text(user.email)),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Pallete.pink),
                      onPressed: () {
                        // Lógica para editar el supervisor
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Pallete.pink),
                      onPressed: () {
                        // Lógica para eliminar el supervisor
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Amiga'),
        backgroundColor: Pallete.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Supervisores',
                style: TextStyle(
                  color: Pallete.pink,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 850),
                Expanded(
                  child: Button(
                    text: 'Crear Supervisor',
                    onPressed: () {
                      Next(context);
                    },
                  ),
                ),
                SizedBox(width: 400),
              ],
            ),
            _buildDataTable(), // Utilizando el DataTable
          ],
        ),
      ),
      drawer: MenuWidget(),
    );
  }
}

class User {
  User(this.name, this.phone, this.ci, this.email);

  final String name;
  final String phone;
  final String ci;
  final String email;
}
