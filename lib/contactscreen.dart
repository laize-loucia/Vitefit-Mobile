import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; //afficher des cartes interactives
import 'package:latlong2/latlong.dart'; //utiliser des coordonnées géographiques
import 'package:url_launcher/url_launcher.dart'; //ouvrir des URL dans un navigateur et des applications

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  //*

  //stockage  des coordonnées
  final LatLng clubLocation =
      const LatLng(48.9872, 1.7170); //constante après son initialisation

  // création d'une URL pour ouvrir Google Maps à un lieu précis dans une application externe
  void _openMaps() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=48.9872,1.7170';
    if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  //**
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contactez-nous au plus vite')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('📍 Club ViteFit - Mantes-la-Jolie',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 250,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
                  ]),
                  child: FlutterMap(
                    options: MapOptions(center: clubLocation, zoom: 15.0),
                    children: [
                      TileLayer(
                          urlTemplate:
                              "https://tile.openstreetmap.org/{z}/{x}/{y}.png"),
                      MarkerLayer(markers: [
                        Marker(
                          point: clubLocation,
                          width: 40,
                          height: 40,
                          child: const Icon(Icons.location_on,
                              color: Colors.red, size: 40),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),

              //***
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: _openMaps,
                icon: const Icon(Icons.directions),
                label: const Text('voir l\'itinéraire Google Maps'),
              ),
              const SizedBox(height: 20),
              const Text(
                  ' Contact : +33 1 23 45 67 89\n Email : clubvitefit@gmail.com',
                  textAlign: TextAlign.center),
              const SizedBox(height: 10),
              const Text(
                  'Horaires :\nLun-Ven : 09h00 - 20h00\nSam : 10h00 - 18h00\nDim : Fermé',
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

//**************************************************************************************
//bibliothèques
//flutter_map - bibliothèque principale qui fournit le widget FlutterMap
//et les classes associées comme MapOptions, TileLayer, et MarkerLayer
//latlong2  - manipuler les coordonnées géographiques ( ->LatLng est une classe de cette bibliothèque)
//url_launcher - liée à FlutterMap pour ouvrir des liens externes (p° sur Google Maps)
//**************************************************************************************

//*

// 1 - final LatLng clubLocation = const LatLng(48.9872, 1.7170);
// Stockage de données géo
////const LatLng(48.9872, 1.7170) = crée une instance avec des coordinnées choisis
//LatLng = classe de la bibliothèque latlong2
//représente une paire de coordonnées géographiques latitude-longitude
//clubLocation = variable cree pour stocker les coordonnées du club Vitefit

//2 - void _openMaps() async { :
//Méthode privée _openMaps()
//crée une URL pour Google Maps avec des coordonnées spécifiques
// vérifie si l'URL peut être ouverte,
//et oui ouvre l'URL dans une application externe

//Déclare une méthode privée nommée _openMaps qui est asynchrone async
//Le mot-clé void indique que cette méthode ne retourne pas de valeur
// Déclare une variable constante final url qui contient l'URL de Google Maps avec les coordonnées de latitude longitude

//if (await canLaunchUrl(Uri.parse(url))) { :
//la conditionnelle attend le résultat de canLaunchUrl
//avec la méthode de la bibliothèque url_launcher, canlaunchurl
//qui vérifie si l'URL peut être lancée
// Uri.parse(url) convertit la chaîne de caractères url en un objet Uri
// = identifier le ressource sur internet

//launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication); :
//Si l'URL peut être lancée,
// la bibliotheqye launchUrl ouvre l'URL dans une application externe
// LaunchMode.externalApplication spécifie que l'URL doit être ouverte en dehors de l'application actuelle
//LaunchMode.externalApplication fait partie de la bibliothèque url_launcher

//**

// -children = contient les couches de la carte, les tuiles de fond tiles et les icones marqueurs

//but : montrer la localisation du club avec un marqueur > sert de CTA

//FlutterMap :
//Fonction d'affiche d'une carte interactive
//FlutterMap widget fourni par la bibliothèque flutter_map
// permet d'intégrer des cartes interactives dans une application Flutter

///Fonctions
/////options: MapOptions(center: clubLocation, zoom: 15.0)
// -MapOptions : Configure la carte pour qu'elle soit centrée sur clubLocation avec un niveau de zoom de 15
// -options =  configure les options de la carte tel qu le controle du zoom
// -TileLayer =  affiche des tuiles de carte de OpenStreetMap pour afficher la carte
// -MarkerLayer = rajoute un marqueur à la position clubLocation avec une icone de localisation rouge

//urlTemplate
// modèle d'url pour les tuiles de la carte
// plus précisément, dans l'url {z}, {x}, et {y} sont des variables
// qui seront remplacées par le niveau de zoom z,
//  et les coordonnées des tuiles x et y
// pour charger les images des tuiles correspondantes

//***
//Ce code ajoute des éléments d'UIinterface  à une colonne comme du text et des espaces verticaux
//ElevatedButton.icon : crée un bouton avec une icône et un label
//pour ouvrir Google Maps en appelant la méthode privée_openMaps
