import 'package:flutter/material.dart';
import './homescreen.dart';
import './gridscreen.dart';
import './program_schedule.dart';
import './contactscreen.dart';
import './header.dart';
//Import des widgets et composants UI de Flutter

//widget avec un état dynamique qui peut être mis à jour
class HomePage extends StatefulWidget {
  const HomePage({super.key});

//_HomePageState est l'état associé à HomePage
  @override
  State<HomePage> createState() => _HomePageState();
}

//création une classe _HomePageState
// -> Gestion des Pages et de l'Index Sélectionné
// création d'une variable privée index pour suivre la page sélectionnée

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

//Création d'une liste des pages navigables -> widgets pour les différents écrans
  static final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const ProgramSchedule(),
    const GridScreen(),
    const ContactScreen(),
  ];

// Création d'une fonction pour mettre à jour
// l'interface lors de la sélection d'un onglet
// Lorsqu'un utilisateur clique sur un onglet,
// la variable _selectedIndex est mise à jour avec
// l'index de l'onglet pressé
// setState() déclenche le rafraîchissement de l'interface,
// ce qui affiche la nouvelle page lié à cet index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // l'annotation @override indique que la méthode `build` surcharge
  // une méthode existante dans la classe parente State (classe de base pour les widgets dynamiques), càd que la version du build est réércite

  //Widget build(BuildContext context) déclare et retourne un widget
  // context est un objet qui contient des informations sur l'arbre des widgets
  // Il permet d'accéder aux styles, themes et autres de l'application

  // Le widget Scaffold gère la mise en page de base dans flutter
// Il donne une structure de base d'une UI prédéfinie (app bar, un body etc.)

// déclaration d'une autre page
  // Utilisation d'une méthode expanded
  // pour affiche dynamiquement la page correspondant à l'index sélectionné
// Expanded permet à la page de prendre tout l'espace restant sous le header

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: Column(
        children: [
          const Header(), // Utilisation du header mis dans un autre fichier header.dart pour simplifier le code de la page
          // Expanded permet à cet élément de prendre tout l’espace disponible restant sous le header
          // Donc la page sélectionnée dans _pages[_selectedIndex])
          // va prendre toute la zone disponible en dessous du header
          // _pages[_selectedIndex] affiche la page correspondant à l'onglet sélectionné
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),

      // Enfin on place les éléments graphiques de la barre de navigation de notre apllication avec une icone et un texte affiché sous l'icone

      //bottomNavigationBar est une propriété de la classe Scaffold
      // Cest cette propriété qui permet d'ajouter une barre de navigation
      //BottomNavigationBar est un widget qui contient une liste d'éléments de navigation BottomNavigationBarItem
      // chaque BottomNavigationBarItem a des propriétés comme icon et label pour définir son apparence et son texte
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Catalogue',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Salles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page),
            label: 'Contacts',
          ),
        ],

        //propriétés du widget BottomNavigationBar
        currentIndex: _selectedIndex,
        // Indique quel élément est actuellement sélectionné en fonction de l’index stocké dans _selectedIndex
        unselectedItemColor: Colors.grey,
        // Couleur des icônes et textes des onglets non sélectionnés
        selectedItemColor: Color(0xff0d0363),
        // Couleur des icônes et textes de l’onglet sélectionné

        //appel de la fonction
        onTap: _onItemTapped,
        // Fonction appelée lors du clic d'un usager sur un élément de la barre de navigation
        // cette même fonction met à jour _selectedIndex avec le nouvel index sélectionné et rafraîchit l'interface.
      ),
    );
  }
}
