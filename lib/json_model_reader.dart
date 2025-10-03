import 'dart:convert';
import 'package:flutter/services.dart' as services;
import 'data_model.dart';

// Reader pour Listroom.json
// Fonction pour lire et parser le fichier JSON
Future<List<RoomModel>> readRoomJsonData() async {
  // Charge le fichier JSON depuis le dossier assets
  final jsonData = await services.rootBundle
      .loadString('assets/json/listroom.json'); // Renommage en listroom.json
  // Décode le JSON en une liste dynamique
  final list = json.decode(jsonData) as List<dynamic>;

  // Transforme chaque élément de la liste en objet RoomModel
  return list.map((e) => RoomModel.fromJson(e)).toList();
}

// Reader pour program.json
Future<List<ProgramModel>> readProgramJsonData() async {
  // 1. Charge le fichier JSON depuis le dossier assets
  final jsonData =
      await services.rootBundle.loadString('assets/json/program.json');

  // 2. Décode le JSON en un objet Map
  final Map<String, dynamic> data =
      json.decode(jsonData) as Map<String, dynamic>;

  // 3. Récupère la liste 'schedule' de l'objet Map
  final List<dynamic> schedule = data['schedule'] as List<dynamic>;

  // 4. Convertit chaque élément de la liste en un objet ProgramModel
  return schedule.map((e) => ProgramModel.fromJson(e)).toList();
}

//Appel des fonctions
//Les étapes de lecture et de parsing des fichiers JSON
//interviennent lors de l'appel des fonctions (readRoomJsonData et readProgramJsonData)
//Ces fonctions ne sont pas exécutées automatiquement au démarrage de l'application,
//mais lorsqu'on a besoin de charger les tu as besoin de charger les données

//Lorsque ces fonctions sont appelées, elles exécutent les étapes de chargement
//et de parsing des fichiers JSON, puis renvoient les listes d'objets RoomModel et ProgramModel

//Le but du code est de parser les 2 fichiers pour créer une liste d'objets program/RoomModel
//Charge le fichier JSON depuis assets
//Décode le JSON en une liste dynamique
//Convertit chaque élément de la liste en un objet ProgramRoomModel
//async
//Indique que la fonction contient des opérations asynchrones, comme des appels réseau ou des lectures de fichier
//utilise l'opérateur await pour attendre la complétion des opérations
//La fonction attend que le fichier JSON soit chargé avant de continuer à exécuter les étapes suivante

//rootBundle : Permet d'accéder aux ressources dans le dossier assets

//e : Représente chaque élément de la liste lors de l'itération avec la méthode map
//Pour chaque élément e de la liste schedule,
//le constructeur fromJson de ProgramModel est appelé pour créer
//une instance de ProgramModel ou RoomModel selon le fichier utilisé
