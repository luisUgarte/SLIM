import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CRUD extends StatefulWidget {
  const CRUD({super.key});

  @override
  State<CRUD> createState() => _CRUDState();
}

class _CRUDState extends State<CRUD> {
  //text field controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ciController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final CollectionReference _registration = 
        FirebaseFirestore.instance.collection('registration');
        // insert, create operation
        // ignore: unused_element
        Future<void> _create ([DocumentSnapshot?documentSnapshot]) async {
          await showModalBottomSheet(
            isScrollControlled: true,
            context: context, builder: (BuildContext ctx) {
              return Padding(padding: EdgeInsets.only(
                top: 20, 
                right: 20, 
                left: 20, 
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Crear registro",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: _emailController, 
                      decoration: const InputDecoration(
                        labelText: 'Correo', hintText: 'eg.test@gmail.com'
                      ),
                    ),
                    TextField(
                      controller: _fullNameController, 
                      decoration: const InputDecoration(
                        labelText: 'Nombre Completo', hintText: 'eg.John Doe'
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _ciController, 
                      decoration: const InputDecoration(
                        labelText: 'CI', hintText: 'eg.99887751'
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _telefonoController, 
                      decoration: const InputDecoration(
                        labelText: 'Telefono', hintText: 'eg.66995521'
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async{
                        final String email = _emailController.text;
                        final String fullname = _fullNameController.text;
                        final int? ci = int.tryParse(_ciController.text);
                        final int? phone = int.tryParse(_telefonoController.text);
                        if (ci != null){
                          await _registration.add(
                            {
                              'email':email, 
                              'full name':fullname, 
                              'ci':ci, 
                              'phone':phone, 
                            },
                          );
                          _emailController.text = '';
                          _fullNameController.text = '';
                          _ciController.text = '';
                          _telefonoController.text = '';

                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        }
                      }, 
                      child: const Text("Crear"))
                  ],
                ),
              );
            }
          );
        }

  //update operation
  Future<void> _update ([DocumentSnapshot?documentSnapshot]) async {
    if(documentSnapshot != null) {
      _emailController.text = documentSnapshot['email'];
      _fullNameController.text = documentSnapshot['full name'];
      _ciController.text = documentSnapshot['ci'].toString();
      _telefonoController.text = documentSnapshot['phone'].toString();
    }
          await showModalBottomSheet(
            isScrollControlled: true,
            context: context, builder: (BuildContext ctx) {
              return Padding(padding: EdgeInsets.only(
                top: 20, 
                right: 20, 
                left: 20, 
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Actualizar registro",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: _emailController, 
                      decoration: const InputDecoration(
                        labelText: 'Correo', hintText: 'eg.test@gmail.com'
                      ),
                    ),
                    TextField(
                      controller: _fullNameController, 
                      decoration: const InputDecoration(
                        labelText: 'Nombre Completo', hintText: 'eg.John Doe'
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _ciController, 
                      decoration: const InputDecoration(
                        labelText: 'CI', hintText: 'eg.99887751'
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _telefonoController, 
                      decoration: const InputDecoration(
                        labelText: 'Telefono', hintText: 'eg.66995521'
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async{
                        final String email = _emailController.text;
                        final String fullname = _fullNameController.text;
                        final int? ci = int.tryParse(_ciController.text);
                        final int? phone = int.tryParse(_telefonoController.text);
                        if (ci != null){
                          await _registration.doc(documentSnapshot!.id).update(
                            {
                              'email':email,  
                              'full name':fullname, 
                              'ci':ci, 
                              'phone':phone, 
                            },
                          );
                          _emailController.text = '';
                          _fullNameController.text = '';
                          _ciController.text = '';
                          _telefonoController.text = '';

                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        }
                      }, 
                      child: const Text("Actualizar"))
                  ],
                ),
              );
            }
          );
        }

  //delete operation
  Future<void> _delete (String productID) async {
    await _registration.doc(productID).delete();

    //for snackBar
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text("Existosamente borrado un registro!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD"),
      ),
      body: StreamBuilder(
        stream: _registration.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData){
            return ListView.builder(itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index){
              final DocumentSnapshot documentSnapshot = 
                streamSnapshot.data!.docs[index];
                return Card(
                  color: const Color.fromARGB(255, 88, 136, 190),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['full name'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, 
                        color: Colors.black
                      ),
                    ),
                    subtitle: Text(documentSnapshot['ci'].toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            color: Colors.black,
                            onPressed: () => _update(documentSnapshot), 
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            color: Colors.black,
                            onPressed: () => _delete(documentSnapshot.id), 
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // create new project button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
      backgroundColor: const Color.fromARGB(255, 88, 136, 190),
      child: const Icon(Icons.add),
      ),
    );
  }
}