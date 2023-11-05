import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miamiga_app/components/listview.dart';
import 'package:miamiga_app/model/datos_denunciante.dart';

class ReadCases extends StatefulWidget {
  const ReadCases({
    super.key,
  });

  @override
  State<ReadCases> createState() => _ReadCasesState();
}

class _ReadCasesState extends State<ReadCases> {

  Future<List<DenuncianteData>> fetchCases() async {
    final QuerySnapshot casesSnapshot = 
      await FirebaseFirestore.instance.collection('cases').get();


      final List<DenuncianteData> casesData = casesSnapshot.docs
        .map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final denuncianteData = data['denunciante'] as Map<String, dynamic>?;

          if (denuncianteData != null) {
            return DenuncianteData(
              fullName: denuncianteData['fullname'] ?? '',
              ci: denuncianteData['ci'] ?? 0,
              phone: denuncianteData['phone'] ?? 0,
              lat: denuncianteData['lat'] ?? 0.0,
              long: denuncianteData['long'] ?? 0.0,
            );
          } else {
            return DenuncianteData(
              fullName: '',
              ci: 0,
              phone: 0,
              lat: 0.0,
              long: 0.0,
            );
          }
        })
        .toList();
        return casesData;
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchCases(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay casos'));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 15.0),
                child: SizedBox(
                  child: MyListView(
                    items: snapshot.data!.map((caseData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(caseData.fullName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('CI: ${caseData.ci}', style: const TextStyle(fontSize: 14)),
                        ],
                      );
                    }).toList(),
                      onItemClick: (int index) {
                      
                    },
                  ),
                ),
              ),
            );
          }
        }
      ),
    );
  }
}