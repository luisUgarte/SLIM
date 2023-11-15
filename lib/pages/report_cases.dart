// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'package:slim_web/components/button.dart';
import 'package:slim_web/components/menu.dart';
import 'package:slim_web/components/pallete.dart';
import 'package:slim_web/components/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  TextEditingController fechaInicioController = TextEditingController();
  TextEditingController fechaFinController = TextEditingController();

  Future<List<Case>> getCasesFromFirestore() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cases')
          .where('estado', isEqualTo: 'finalizado')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final casesList = querySnapshot.docs.map((e) async {
          final data = e.data() as Map<String, dynamic>;
          final supervisor = data['supervisor'] as DocumentReference;
          final dataSupervisor = await supervisor.get();
          final supervisorData = dataSupervisor.data();

          final supervisorClass = Supervisor.fromJson(
              supervisorData as Map<String, dynamic>, supervisor.id);

          return Case.fromJson(data, supervisorClass.fullname);
        }).toList();

        print('Aaaa');

        return Future.wait(casesList);
      }

      return [];
    } on FirebaseException {
      return [];
    }
  }

  // Future<List<Case>> filterCasesByDate(
  //     DateTime startDate, DateTime endDate, List<Case> cases) async {
  //   return cases.where((caseItem) {
  //     return caseItem.date.isAfter(startDate) &&
  //         caseItem.date.isBefore(endDate);
  //   }).toList();
  // }

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
            Text(
              'Reporte',
              style: TextStyle(
                color: Color(0xFFD15A7C),
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: MyTextField(
                      hintText: 'Fecha inicio',
                      obscureText: false,
                      isEnabled: true,
                      controller: fechaInicioController,
                      labelText: 'Fecha inicio',
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: MyTextField(
                      hintText: 'Fecha fin',
                      obscureText: false,
                      isEnabled: true,
                      controller: fechaFinController,
                      labelText: 'Fecha fin',
                    ),
                  ),
                ),
                Expanded(
                  child: Button(
                    text: 'pdf',
                    onPressed: () async {
                      DateTime startDate =
                          DateTime.parse(fechaInicioController.text);
                      DateTime endDate =
                          DateTime.parse(fechaFinController.text);

                      List<Case> allCases = await getCasesFromFirestore();
                      // List<Case> filteredCases =
                      //     await filterCasesByDate(startDate, endDate, allCases);

                      // Ahora 'filteredCases' contiene solo los casos en el rango de fechas seleccionado

                      // Acción del botón PDF
                    },
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: FutureBuilder<List<Case>>(
                future: getCasesFromFirestore(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Case> cases = snapshot.data ?? [];
                    return DataTable(
                      columns: [
                        DataColumn(label: Text('Nombre')),
                        DataColumn(label: Text('Teléfono')),
                        DataColumn(label: Text('CI')),
                        DataColumn(label: Text('Supervisor')),
                        DataColumn(label: Text('Estado')),
                        DataColumn(label: Text('Acción')),
                      ],
                      rows: cases
                          .asMap()
                          .entries
                          .map(
                            (entry) => DataRow(
                              color: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (entry.key.isEven) {
                                    return Colors.white;
                                  } else {
                                    return Colors.grey[200] ?? Colors.white;
                                  }
                                },
                              ),
                              cells: [
                                DataCell(
                                    Text(entry.value.denunciante.fullname)),
                                DataCell(Text(
                                    entry.value.denunciante.phone.toString())),
                                DataCell(Text(
                                    entry.value.denunciante.ci.toString())),
                                DataCell(Text(entry.value.supervisor)),
                                DataCell(Text(entry.value.estado)),
                                DataCell(
                                  IconButton(
                                    icon: Icon(Icons.visibility),
                                    onPressed: () {
                                      // Lógica para ver detalles del usuario
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      drawer: MenuWidget(),
    );
  }
}

class Case {
  Case({
    required this.supervisor,
    required this.incidente,
    required this.fecha,
    required this.oficial,
    required this.estado,
    required this.denunciante,
    required this.user,
  });

  final String supervisor;
  final Incidente incidente;
  final DateTime fecha;
  final String oficial;
  final String estado;
  final Denunciante denunciante;
  final String user;

  factory Case.fromJson(Map<String, dynamic> json, String nameSupervisor) {
    Timestamp firestoreTimestamp = json['fecha'];
    DateTime dateTime = firestoreTimestamp.toDate();
    final supervisor = json['supervisor'] as DocumentReference;
    final data = supervisor.get();
    final supervisorData = data.then((value) => value.data());
    return Case(
        supervisor: nameSupervisor,
        incidente: Incidente.fromJson(json['incidente']),
        fecha: dateTime,
        oficial: json['oficial'] ?? '',
        estado: json['estado'] ?? '',
        denunciante: Denunciante.fromJson(json['denunciante']),
        user: json['user'] ?? '');
  }
}

class Incidente {
  Incidente({
    required this.lat,
    required this.long,
    required this.userid,
    required this.audioUrl,
    required this.imageUrl,
    required this.descriptionIncidente,
    required this.fechaIncidente,
  });
  final double lat;
  final double long;
  final String userid;
  final String audioUrl;
  final List<String> imageUrl;
  final String descriptionIncidente;
  final DateTime fechaIncidente;

  factory Incidente.fromJson(Map<String, dynamic> json) {
    Timestamp firestoreTimestamp = json['fechaIncidente'];
    DateTime dateTime = firestoreTimestamp.toDate();
    return Incidente(
        lat: json['lat'] ?? 0.0,
        long: json['long'] ?? 0.0,
        userid: json['userid'] ?? '',
        audioUrl: json['audioUrl'] ?? '',
        imageUrl: [],
        descriptionIncidente: json['descriptionIncidente'] ?? '',
        fechaIncidente: dateTime);
  }
}

class Denunciante {
  Denunciante({
    required this.ci,
    required this.userId,
    required this.phone,
    required this.long,
    required this.lat,
    required this.fullname,
  });

  final int ci;
  final String userId;
  final int phone;
  final double long;
  final double lat;
  final String fullname;

  factory Denunciante.fromJson(Map<String, dynamic> json) {
    return Denunciante(
        ci: json['ci'] ?? 0,
        userId: json['userId'] ?? '',
        phone: json['phone'] ?? 0,
        long: json['long'] ?? 0.0,
        lat: json['lat'] ?? 0.0,
        fullname: json['fullname'] ?? '');
  }
}

class Supervisor {
  Supervisor({
    required this.id,
    required this.ci,
    required this.email,
    required this.fullname,
    required this.password,
    required this.phone,
  });

  final String id;
  final int ci;
  final String email;
  final String fullname;
  final String password;
  final int phone;

  factory Supervisor.fromJson(Map<String, dynamic> json, String id) {
    return Supervisor(
        id: id,
        ci: 0,
        email: json['email'] ?? '',
        fullname: json['fullname'] ?? '',
        password: json['password'] ?? '',
        phone: 0);
  }
}
