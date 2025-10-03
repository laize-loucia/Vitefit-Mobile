import 'package:flutter/material.dart';

//*
//Déclaration de la variable room
// Définit une variable membre pour stocker les données de la salle
class GridDetailPage extends StatelessWidget {
  final Map<String, dynamic>
      room; //Déclaration de la variable room pour stocker les données de la salle

// Utilisation du constructeur pour créer des instances de GridDetailPage en passant les données de la salle via le paramètre room
  const GridDetailPage({Key? key, required this.room}) : super(key: key);

  //**
  //récupération des données JSON des images
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(room['name'] ?? "Détails de la salle"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Affiche l'image de la salle
            Center(
              child: room["image"] != null
                  ? Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/${room["image"]}'),
                          fit: BoxFit.cover, // Ajuste l'image sans la déformer
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: room["image"] == null
                            ? const Icon(
                                Icons.broken_image,
                                size: 200,
                                color: Colors.grey,
                              )
                            : null, // Affiche l'icone si l'image est absente
                      ),
                    )
                  : const Icon(
                      Icons.broken_image,
                      size: 200,
                      color: Colors.grey,
                    ),
            ),
            const SizedBox(height: 16),

            //***
            //récupération des données JSON textuelles
            // Nom de la salle
            Center(
              child: Text(
                room['name'] ?? "Sans nom",
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            // Adresse
            Center(
              child: Text(
                'Adresse: ${room["address"] ?? "Adresse inconnue"}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),

            // Horaires d'ouverture
            Center(
              child: Text(
                'Horaires: ${room["opening_hours"] ?? "Horaires inconnus"}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//*

//Déclaration de la classe
// lors de la création d'une nouvelle classe GridDetailPage
// Déclaration de la variable room
//  on définit une variable membre pour stocker les données de la salle
// Une variable room de type Map<String, dynamic> est crée
// La variable room est un dictionnaire qui contient les données de la salle

//Constructeur = pour créer des instances de GridDetailPage en passant les données de la salle via le paramètre room
//const GridDetailPage({Key? key, required this.room}) : super(key: key);
// constructeur pour la classe GridDetailPage
// crée une instance de GridDetailPage
// avec {Key? key, required this.room} = liste de paramètres nommés
// key = paramètre optionnel de type Key, et room est un paramètre requis de type Map<String, dynamic>
// super(key: key) : Appelle le constructeur de la classe parente StatelessWidget avec le paramètre key

//**
//-Le widget SingleChildScrollView contient le widget Column
// Cela permet à l'utilisateur de faire défiler verticalement tout le contenu de la colonne si nécessaire etle padding ajoute un espace de 16 pixels autour du contenu
//-La conditionnelle vérifie si la clé "image" dans le dictionnaire room n'est pas nulle
//Si oui un widget Container est créé avec une largeur et une hauteur fixes de 200 pixels
//La décoration du conteneur utilise DecorationImage pour afficher l'image spécifiée par room["image"]
// L'image est ajustée pour couvrir tout l'espace sans être déformée (BoxFit.cover)
//  Si non  l'image est absente, une icône par défaut est affichée, Icons.broken_image) est affichée avec une taille de 200 px et une couleur grise

//***

//Récupération des données JSON
//Utilisation de l'interpolation de chaînes
//->insérer les valeurs de variable dans une chaîne de caractères avec le dollar $
//= pour récupérer les valeurs des clés du dictionnaire room
// affichage des données dans les widgets Text

// dans  room['name'] on accède à la valeur associée à la clé 'name'
// dans le dictionnaire room
