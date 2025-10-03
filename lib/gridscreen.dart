import 'package:flutter/material.dart';
import 'json_model_reader.dart';
import 'data_model.dart';
import 'grid_detail_page.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({Key? key}) : super(key: key);

  @override
  State<GridScreen> createState() => _GridScreenState();
}

//*
// déclaration de la classe
class _GridScreenState extends State<GridScreen> {
  late Future<List<RoomModel>>
      futureRooms; //déclare une variable futureRooms de type Future<List<RoomModel>>

  @override
  void initState() {
    super.initState();
    futureRooms = readRoomJsonData();
  }

  //**
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Salles de sport')),
      body: FutureBuilder<List<RoomModel>>(
        future: futureRooms,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }
          //Récupération des données
          //Accès aux données contenues dans snapshot
          final rooms = snapshot.data ?? [];
          if (rooms.isEmpty) {
            return const Center(child: Text('Aucune salle trouvée'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 3 / 4,
            ),
            itemCount: rooms.length,
            itemBuilder: (context, index) => RoomCard(room: rooms[index]),
          );
        },
      ),
    );
  }
}

//***
//Déclaration de la classe RoomCard
class RoomCard extends StatelessWidget {
  final RoomModel
      room; //Déclare une variable room de type RoomModel qui contient les données de la salle

  const RoomCard({Key? key, required this.room}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => GridDetailPage(room: room.toJson()),
        ),
      ),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/${room.image ?? "default.jpg"}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    room.name ?? "Nom inconnu",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(room.address ?? "Adresse inconnue"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//**********************************************************************
//Future - valeur/ erreur qui sera affiché à un moment donné dans le futur (pour des opérations asynchrones)
//Snapshot - un objet contenant les informations sur l'état actuel d'un Future
//ou d'un Stream dans un FutureBuilder ou un StreamBuilder
////Il permet de savoir si le Future est en cours de chargement, s'il a réussi, ou s'il a échoué, et de récupérer les données ou l'erreur correspondante
//**********************************************************************

//*
//futureRooms = readRoomJsonData();
// Initialise la variable futureRooms
// via l'appel de la fonction readRoomJsonData()
// qui retourne un Future contenant une liste des données RoomModel du fichier
//  = Cela pemet de rzcupérer les données JSON de manière asynchrone

//**
//fonction builder
//construit l'UI en fonction de l'état du Future qui futureRooms
//arbe de conditionnelles :
//-snapshot.connectionState == ConnectionState.waiting :
//Si le future est en cours de chargement, affiche un indicateur de progression circulaire (CircularProgressIndicator)
//-snapshot.hasError :
//Si le Future a une erreur, affiche un message d'erreur
//-snapshot.data : Si le Future est complété avec succès, récupère les données (ici, une liste de RoomModel)
//-rooms.isEmpty : Si la liste des salles est vide, affiche un message indiquant qu'aucune salle n'a été trouvée

//final rooms = snapshot.data ?? [];
//Récupération des données
//Accès aux données contenues dans snapshot//Récupération des données
//Accès aux données contenues dans snapshot
// contient le résultat du Future (ici, une liste de RoomModel)
// Opérateur de coalescence nulle (??)
//Si snapshot.data est nul
// càd que le Future n'a pas retourné de données)
//  cette expression retourne une liste vide []
//  Cela permet de s'assurer que rooms ne sera jamais nul et contiendra toujours une liste, même si elle est vide

//GridView.builder
//créer une grille avec 2 colonnes
// Si des données sont disponibles, affiche les salles sous forme de grille
//Chaque élément de la grille est mis en forme de RoomCard
//qui affichent les informations de la salle

//***
//La méthode build construit l'UI pour ce widget
// Le widget GestureDetector détecte les gestes, comme les taps
// Propriété onTap définit une fonction à démarrer quand exécuter le widget est cliqué
// La méthode Navigator.push renvoie alors vers une nouvelle page GridDetailPage d'un
// autre fichier de l'arborescence à chaque cic détecté
//La classe MaterialPageRoute crée une route de navigation vers une nouvelle page
// La fonction builder retourne le widget de la nouvelle page
// Ici, elle crée une instance de GridDetailPage en passant les données
//  de la salle converties en JSON (room.toJson())
