import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  // Liste statique des actualités en dur
  final List<Map<String, String>> newsList = const [
    {
      "title": "Prochainement : nouvel entraînement disponible !",
      "content":
          "Essayez notre programme Vitality HIIT de 15 minutes pour brûler des calories en toute efficacité!"
    },
    {
      "title": "Green marathon [challenge]",
      "content":
          "Vitefit organise le Green Marathon le 5 avril 2025 : parcourir Paris en ramassant les déchets tout en courant. Plus d'informations seront données sur place..."
    },
    {
      "title": "Événement sportif ce week-end",
      "content":
          "Ne manquez pas notre course à pied communautaire dimanche matin à 10h le 9 février 2025 !"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image de fond avec un effet de vague
        // Appel de la fonction
        WavyHeaderImage(),

        // Logo et texte "ViteFit" en haut à gauche
        Positioned(
          top: 20,
          left: 20,
          child: Row(
            children: [
              // Logo avec des bords arrondis
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/mycustomlogo.png',
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "ViteFit",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        // Icônes en haut à droite
        Positioned(
          top: 20,
          right: 20,
          child: Row(
            children: [
              // Icône de notification avec une pastille rouge
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications,
                        color: Colors.white, size: 24),
                    onPressed: () => _navigateToNewsPage(context),
                  ),
                  if (newsList.isNotEmpty)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          newsList.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 10),

              // *
              // Icône d'information
              IconButton(
                icon: const Icon(Icons.info, color: Colors.white, size: 24),
                onPressed: () {
                  //méthode utilisée pour afficher un SnackBar, qui est un widget contenant un msg éphémère
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Les données affichées dans cette application sont fictives et ont été générées à des fins de démonstration. "
                        "Conformément au RGPD, aucune donnée personnelle réelle n'a été utilisée ou collectée pour cette application.",
                      ),
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  //**
  // Navigation vers la page des actualités
  void _navigateToNewsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsPage(newsList: newsList),
      ),
    );
  }
}

//***
// Page des actualités
class NewsPage extends StatelessWidget {
  final List<Map<String, String>> newsList;

  const NewsPage({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actualités"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.indigo[50],
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    newsList[index]["title"]!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo[900],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    newsList[index]["content"]!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ****
// Widget pour l'image de fond avec un effet de vague
class WavyHeaderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomWaveClipper(), // Applique l'effet de vague
      child: Container(
        height: 210,
        decoration: BoxDecoration(
          color: Colors.indigo[900],
          image: const DecorationImage(
            image: AssetImage('assets/images/header_background.webp'),
            fit: BoxFit
                .cover, //l'image doit couvrir tout l'espace disponible du conainer tout en conservant son ratio
          ),
        ),
      ),
    );
  }
}

//*****
// Classe pour créer l'effet de vague en bas du header
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// *

//ScaffoldMessenger.of(context).showSnackBar
//Icône d'information
//Ce code crée un bouton d'icône dans une application Flutter
//quand l'utiisateur appuie sur ce bouton,un message s'affiche sous forme de SnackBar en bas de l'écran

//ScaffoldMessenger.of(context).showSnackBar :
//Méthode qui affiche une SnackBar = notification temporaire
//Le parent ScaffoldMessenger gère l'affichage des SnackBars

//SnackBar Widget du contenu de la notification SnackBar
//Parent : showSnackBar méthode de ScaffoldMessenger

//content propriété du widget SnackBar
//Définit le contenu principal du SnackBar, ici un texte informatif sur le RGPD

//**

//Fonction _navigateToNewsPage :
// cree une navigation vers une nouvelle page appelée NewsPage.
// avec la fonction Navigator.push pour ajouter une nouvelle route

// La classe MaterialPageRoute est utilisé pour créer une route
// qui construit la NewsPage
// La NewsPage reçoit la liste cree en dur newsList en tant que paramètre

//***
//Cette partie du code définit la page d'actualités NewsPage
//qui affiche une liste d'actualités sous forme de cartes
//Chaque carte contient un titre et un contenu stylise

// les propriétés

//newsList :
//Liste de cartes (List<Map<String, String>>).
//Contient les données des actualités,
//avec chaque carte ayant des clés title et content

//itemCount :
//Propriété de ListView.builder.
//Spécifie le nombre d'éléments dans la liste -> longueur de newsList

//itemBuilder :
//Fonction anonyme qui construit chaque élément de la liste
//en utilisant les données de newsList

//newsList[index]["title"] :
//Accès à une valeur dans la carte = recupere le titre de
//l'actualité à l'index donné.newsList

//****
// widget personnalisé WavyHeaderImage -> utilise un effet de découpe en vague avec l'image
// Pour ca il utilise d'autres widgets :
// -ClipPath = widget qui découpe son enfant containet (des décorations pour afficher l'image de fond)
// selon une forme personnalisée définie par un CustomClipper, ici BottomWaveClipper

// -BottomWaveClipper = classe pour créer l'effet de vague
// Elle étend CustomClipper<Path> et implémente la méthode getClip
// pour définir la forme de découpe

// Avec clipper: BottomWaveClipper(), on cree une instance de BottomWaveClipper
// et on l'appliques au widget Clippath
//  Cela signifie que ClipPath utilisera
// la forme définie par BottomWaveClipper dans la fonction pour découper son enfant

// -Container : widget contenant l'image de fond et appliquant des décorations...
// -BoxDecoration = widget définisant des décorations pour le container
// -DecorationImage = widget utilisé pour spécifier l'image de fond et son ajustement dans container

//fit: BoxFit.cover"
// Configuration du widget decorationImage
// Elle spécifie comment l'image doit être ajustée dans le Container

//*****

// Source: https://iiro.dev/clipping-widgets-with-bezier-curves-in-flutter
//Méthode getClip
//appelée pour obtenir le chemin Path qui définit la forme de découpe

// Path -> Initialisation du chemin :
// Path = classe qui représente un chemin de dessin

//Méthode quadraticBezierTo
//crée une courbe quadratique de Bézier
//Le 1er point de contrôle influence la courbure de la vague
// et le point de fin indique ou la courbe se termine

//Méthode lineTo
// trace des lignes droites pour compléter le contour du chemin
//close ferme le chemin en reliant le dernier point au premier point

//Méthode shouldReclip
//indique si le clipper doit redécouper le chemin lorsque le widget est reconstruit

//Offset = classe en Flutter
// C'est une position en 2D avec des coordonnées dx (axe horizontal) et dy (axe vertical)
