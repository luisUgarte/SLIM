import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Widget> _screens = [
    Container(
      color: Colors.yellow.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Inicio',
        style: TextStyle(fontSize: 40),
      ),
    ),
    Container(
      color: Colors.purple.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Denuncia',
        style: TextStyle(fontSize: 40),
      ),
    ),
    Container(
      color: Colors.pink.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Perfil',
        style: TextStyle(fontSize: 40),
      ),
    ),
  ];
  //el selectedIndex nos sirve para que cuando seleccionamos un ventana tiene que cambiar su indice de ventana
  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: const Text("Resposive Site"),
      ), */

      //MediaQuery es lo que haremos que la pagina web sea responsive cuando es menor que 640
      bottomNavigationBar: MediaQuery.of(context).size.width < 640 ? Container(
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
              GButton(icon: Icons.warning_rounded, text: 'Denuncia'),
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
      ):null,

      body: Row(
        children: [
          //MediaQuery es lo que haremos responsivo cuando sea mayor e igual que 640 esto es movil
          if (MediaQuery.of(context).size.width >= 640)
          NavigationRail(
            //usamos onDestinationSelected para poder hacer click y llamar a nuestro variable _selectedIndex y es entero
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },

            selectedIndex: _selectedIndex,
            destinations: const[
              NavigationRailDestination(
                icon: Icon(Icons.home), label: Text('Inicio')),
              NavigationRailDestination(
                icon: Icon(Icons.warning_rounded), label: Text('Denuncia')),
              NavigationRailDestination(
                icon: Icon(Icons.person), label: Text('Perfil')),
            ],

            labelType: NavigationRailLabelType.all,
            selectedLabelTextStyle: const TextStyle(
              color: Colors.teal
            ),

            unselectedLabelTextStyle: const TextStyle(),

            leading: const Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person),
                ),
              ],
            ),
          ),
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
    );
  }
}