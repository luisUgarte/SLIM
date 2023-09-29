import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:miamiga_app/pages/edit_perfil.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';

class InicioScreen extends StatelessWidget {
  final User? user;

  Future<String> getUserName(User? user) async {
  if (user != null) {
    // Check if the user is signed in with Google
    if (user.providerData.any((userInfo) => userInfo.providerId == 'google.com')) {
      // If signed in with Google, return the user's display name
      return user.displayName ?? 'Usuario desconocido';
    } else {
      // If not signed in with Google, you can implement a different logic
      // to get the user's name based on your authentication method.
      // For example, if using email/password, you can fetch it from Firestore
      // or another database using the user's UID.
      // Here's an example using Firestore:

      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('registration')
            .doc(user.uid)
            .get();

        if (snapshot.exists) {
          final fullName = snapshot.get('full name');
          return fullName;
        } else {
          return 'Usuario desconocido';
        }
      } catch (e) {
        // ignore: avoid_print
        print('Error getting user name: $e');
        return 'Usuario desconocido';
      }
    }
  } else {
    return 'Usuario desconocido';
  }
}

  const InicioScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              FutureBuilder<String>(
                future: getUserName(user),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    final userName = snapshot.data ?? 'Usuario desconocido';
                    return Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              'Bienvenido, $userName',
                                style: const TextStyle(fontSize: 40),
                                textAlign: TextAlign.start,
                            ),
                          ),
                          if (user != null)
                          Text(
                            'Email: ${user!.email ?? 'Email no disponible'}',
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
