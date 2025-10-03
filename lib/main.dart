import 'package:flutter/material.dart';
import './homepage.dart';
//Import des widgets et composants UI de Flutter

// La fonction main est le point d'entrée de l'application Flutter, exécutée en 1er
// La fonction runApp démarre l'application et l'afiche en prenant un widget racine MyApp()
void main() => runApp(const MyApp());

// Une classe MyApp est définit.
// La classe hérite de statelessWidget,
// Un stateles widget est un w qui ne change pas une fois créé

// Constructeur de la classe MyApp
// Avec const on indique que cette instance est une constante
// Le paramètre key est passé au constructeur parent (super.key)
// Cela permet à Flutter d'identifier ce widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // L'annotation indique que la méthode build est une surcharge *
  //  d'une méthode de la classe parente StatelessWidget

  // La méthode build est obligatoire pour un StatelessWidget
  // Elle permet à flutter de construire l'UI du widget

  // Dans BuildContext contex, xontext est un objet
  // Il donne des informations sur l'emplacement du widget dans l'arbre des widgets

  // La ligne suivante retourne un widget MaterialApp
  // MaterialApp est un widget racine pour les applications Flutter
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rendu Front end avancé 2024 - 2025',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}

// Désactive la bannière de débogage apparaissant par défaut dans les applications Flutter
// La propriété home prend comme valeur le widget HomePage() est définit comme celui qui sera affiché lors du boot de l'application démarre
// Ce widget est importé depuis homepage.dart

// * surcharge = définir pls méthodes avec un nom commun mais différents paramètres
//  Cela permet à une classe de réutiliser le même nom de méthode
// pour différentes opérations, en fonction des paramètres passés à la méthode.

// ->ici l'annotation veut dire que la méthode build est une surcharge
// d'une méthode de la classe parente StatelessWidget
// La méthode remplace la méthode build de la classe parente
