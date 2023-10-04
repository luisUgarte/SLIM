// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
<<<<<<< HEAD
import 'package:miamiga_app/pages/denuncia.dart';
=======
import 'package:miamiga_app/pages/sobre.dart';
>>>>>>> origin/johan
import 'package:miamiga_app/pages/inicio.dart';

import 'package:miamiga_app/pages/perfil.dart';

class Screens extends StatefulWidget {
  const Screens({Key? key}) : super(key: key);

  @override
  _ScreensState createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  final User? user = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;
  late List<Widget> _screens;

  void signUserOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
  }


  @override
  void initState() {
    super.initState();

    _screens = [
      InicioScreen(user: user!),
<<<<<<< HEAD
      const DenunciaScreen(),
=======
      const SobreScreen(),
>>>>>>> origin/johan
      PerfilScreen(user: user!),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _screens[_selectedIndex],
            ),
            Container(
              color: const Color.fromRGBO(192, 108, 132, 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
                child: GNav(
                  backgroundColor: const Color.fromRGBO(192, 108, 132, 1),
                  color: Colors.white,
                  activeColor: Colors.white,
                  tabBackgroundColor: const Color.fromRGBO(248, 181, 149, 1),
                  gap: 8,
                  padding: const EdgeInsets.all(16),
                  tabs: const [
                    GButton(icon: Icons.home, text: 'Inicio'),
<<<<<<< HEAD
                    GButton(icon: Icons.warning_rounded, text: 'Denuncia'),
=======
                    GButton(icon: Icons.info, text: 'Sobre'),
>>>>>>> origin/johan
                    GButton(icon: Icons.person, text: 'Perfil'),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
