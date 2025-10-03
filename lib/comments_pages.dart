import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommentairesPage extends StatefulWidget {
  @override
  _CommentairesPageState createState() => _CommentairesPageState();
}

//*

// 1 - Stockage et initialisation des variables
//Déclare une classe _CommentairesPageState qui gère l'état du widget CommentairesPage
class _CommentairesPageState extends State<CommentairesPage> {
  List<dynamic> membres = [];
  bool isLoading = true;
  String errorMessage = '';

//variable contenant l'URL de l'API pour recuperer les donnees des membres
  final String apiUrl =
      'https://my.api.mockaroo.com/members_vitefit.json?key=b8e05d40';

// 2 - initialisation de l'état du widget et récupération des données JSON
  @override
  void initState() {
    super.initState();
    fetchMembres(); //récupère les données des membres depuis l'API
  }

// 3 - récupération des données des membres depuis une API
  Future<void> fetchMembres() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          membres = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Erreur ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Erreur de connexion';
        isLoading = false;
      });
    }
  }

  //**
  //Gestion de l'interface utilisateur
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Membres du Club'),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.grey[200],
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child:
                      Text(errorMessage, style: TextStyle(color: Colors.red)))
              : ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: membres.length,
                  itemBuilder: (context, index) {
                    final m = membres[index];
                    final avatarUrl =
                        'https://ui-avatars.com/api/?name=${Uri.encodeComponent(m['full_name'] ?? 'Membre')}&background=random';

                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(avatarUrl),
                                  radius: 25,
                                ),
                                SizedBox(width: 10),

                                // Utilisation de Expanded ici pour éviter le débordement
                                Expanded(
                                  child: Text(
                                    m['full_name'] ?? 'Nom inconnu',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    overflow: TextOverflow
                                        .ellipsis, // Limiter le texte qui dépasse
                                  ),
                                ),
                              ],
                            ),

                            //***
                            //Mise en forme
                            SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Icon(Icons.location_on,
                                      color: Colors.red, size: 16),
                                  SizedBox(width: 5),
                                  Text(
                                    '${m['place'] ?? 'Lieu inconnu'}, ${m['state'] ?? 'État inconnu'}',
                                    style: TextStyle(fontSize: 14),
                                    overflow: TextOverflow
                                        .ellipsis, // Limite la largeur du texte
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.person,
                                    color: Colors.blue, size: 16),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                      'Genre: ${m['gender'] ?? 'Non spécifié'}'),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.work, color: Colors.green, size: 16),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                      'Métier: ${m['job'] ?? 'Non renseigné'}'),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.access_time,
                                    color: Colors.orange, size: 16),
                                SizedBox(width: 5),
                                Text(
                                    'Fuseau horaire: ${m['time'] ?? 'Non disponible'}'),
                              ],
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

//Source : https://mockaroo.com/

//*

// 1 - Stockage et initialisation des variables
//List<dynamic> membres = []; :
//Initialise une liste vide nommée membres pour stocker les données des
// membres récupérées depuis l'api

//bool isLoading = true; :
// Initialise une variable isLoading à true
// pour indiquer que les données sont en cours de chargement

//String errorMessage = ''; :
//Initialise une variable errorMessage avec une chaîne vide
// stocker les messages d'erreur en cas de problème de récupération des données

// String apiUrl = 'https://my.api.mockaroo.com/members_vitefit.json?key=b8e05d40';
// Déclare une variable stockant l'url de l'api pour récupérer les données des membres

// 2 - initialisation de l'état du widget et récupération des données JSON
//-void initState() :
//Déclare la méthode initState, appelée quand l'état du widget est initialisé
//-super.initState(); :
//Appelle la méthode initState de la classe parente State
//afin de vérifié que l'initialisation dans la classe parente est faite
// - Méthode fetchMembres(); :
//récupère les données des membres depuis l'API

// 3 - récupération des données des membres depuis une API

// but de la méthode : envoier une requête HTTP
// pour récupérer les données des membres,
// met à jour l'état du widget avec les données récupérées
// ou affiche les messages d'erreur
// et enfin gère les exceptions pour assurer une expérience utilisateur fluide

// Arbres de conditionnels
// - Méthode setState
// Met à jour l'état interne de l'objet
//  et déclenche une reconstruction de l'UI pour afficher les changements

// - try
// Mot-clé  pour gérer les erreurs
// Il enclenche un bloc de code sur des exceptions prévues

// - isLoading :
//Indique si les données sont en cours de chargement
//=  permet de gérer l'affichage de l'UI et amèliorer l'UX

// -errorMessage :
//Variable d'état qui stocke les messages d'erreur et informer l'usager
// lors de problème de récupération des données

//**
// -variable d'état isLoading :
//Affiche un indicateur de chargement (CircularProgressIndicator) si les données chargent

// -variable d'état errorMessage :
//Affiche un message d'erreur centré si une erreur s'est produite lors de la récupération des données

//-widget ListView.builder :
//Construit une liste déroulante d'éléments selon les données des membres

//-Card widget :
//Affiche chaque membre dans une carte
//Contient les informations du membre, comme l'avatar et le nom

//- widget CircleAvatar
//Affiche l'avatar du membre en utilisant une image réseau pour afficher

//***
//Afficher les détails des membres du club avec des icônes et des textes pour présenter les informations json mieux
//-SingleChildScrollView
//Faire défiler son contenu si celui-ci dépasse la largeur ou la hauteur de l'écran
//Ici, faire défiler horizontalement le widget Row contenant des icônes et du texte

//Text :
//Utilise des expressions pour insérer dynamiquement les valeurs
//des membres récupérées depuis le json de l'api

// ->Appel du JSON
// Dans les lignes comme ${m['place'] ?? 'Lieu inconnu'}, ${m['state'] ?? 'État inconnu'}
//récupère la valeur de place depuis l'objet m (membre individuel s la liste membres)
//Utilisé pour accéder aux propriétés spécifiques de chaque membre (comme place, state, gender, etc...) dans les expressions de texte
// par exemple si place est null, affiche 'Lieu inconnu'
