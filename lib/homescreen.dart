import 'package:flutter/material.dart';
import 'dart:convert'; // import pour prendre en charg la réponse JSON
import 'comments_pages.dart'; // création d'une page pour afficher les commentaires

// 1 - Déclaration une nvll class qui représente un widget nommmé HomeScreen
// le widget hérite d'un état actif > StatefulWidget

// 2 - constructeur de la classe HomeScreen
// Il prend un paramètre optionnel key
// Avec key, il appelle le constructeur de la classe parente StatefulWidget avec ce key

// 3 - Méthode_HomeScreenState createState() => _HomeScreenState();
// On crée un état associé au widget HomeScreen : _HomeScreenState
// On retourne une nouvelle instance de _HomeScreenState :
// càd, une classe d'état associée à HomeScreen
// Ca permet à HomeScreen de gérer son état interne

// -> _HomeScreenState est donc la classe privée qui gère l'état du widget HomeScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//Cette classe gère l'état du widget HomeScreen

//La méthode build est redéfinie pour construire l'UI
// Elle retourne un widget Scaffold (qui contient l'UI principale de l'application)
// on ajout une barre d'application (AppBar) en haut de l'écran avec un titre
// avec la propriété qui crée le widget
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenue'),
      ),

      //Le corps de la page est un SingleChildScrollView
      // =  faire défiler le contenu
      // contient des propriétés et des widgets

      // Ajout des propriétés :
      // EdgeInsets.all(16.0) =  padding autour du contenu
      // BouncingScrollPhysics() = effet de scroll fluide
      // child: Column( = organiser les widgets verticalement
      // CrossAxisAlignment.star = alignement des enfants de la colonne à gauche

      //children: [ =  déclare les enfants de la colonne
      //Container(= conteneur à bordure et coins arrondis
      //decoration = BoxDecoration(: décorations pour le conteneur :
      //border: Border.all(color: Colors.blueAccent) = bordure
      //borderRadius: BorderRadius.circular(8.0) = arrondir les coins

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        physics: const BouncingScrollPhysics(), // Effet de scroll
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          // déclaration les enfants de la colonne
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                // déclare les enfants de la colonne
                children: const [
                  Text(
                    'Application Vitefit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),

                  //Enfant > widget Text (descendant de SCSV)
                  Text(
                    '070990581DD',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Laizé Loucia',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '© 2025 IUT de Bobigny',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            //Widget d'espacement vertical entre les widgets
            const SizedBox(height: 20),

            // Affichage de l'image d'accueil
            Center(
              child: Image.asset(
                'assets/images/homepage_background.webp', // Chemin de l'image en localS
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Sections d'informations
            _buildSectionTitle("Présentation"),
            _buildSectionContent(
              "Vitefit a ouvert en 2018 et n'a cessé de se développer depuis. Ses créateurs sont d'anciens joueurs de badmintons professionnels qui ont racheté le club pour se reconvertir dans le health care et le fitness.",
            ),
            _buildSectionTitle("Abonnement"),
            _buildSectionContent(
              "Tout adhérent peut s'inscrire aux cours du lundi, mardi et mercredi grâce à l'abonnement par jour sur place...",
            ),
            _buildSectionTitle("À venir"),
            _buildSectionContent(
              "En février 2024, Vitefit ouvrira une salle VR pour les personnes en convalescence...",
            ),
            _buildSectionTitle("Qui sommes-nous ?"),
            _buildSectionContent(
              "VITEFIT est composé de coachs qualifiés partageant des valeurs de santé, engagement et persévérance...",
            ),
            _buildSectionTitle("Avis des habitués"),
            _buildSectionContent(
              "Cassandra (29 ans) : 'Je viens chaque semaine depuis 2 ans et je suis toujours surprise par les changements au fil des mois.'\n\n"
              "Yassin (48 ans) : 'L'ambiance est sérieuse et bon enfant.'\n\n"
              "Akmar (74 ans) : 'Ce qui m'a frappé, c'est la qualité du suivi sportif. Club dynamique et sérieux.'",
            ),
            _buildSectionTitle("Nos valeurs"),
            _buildSectionContent(
              "Santé : 3,2 millions de décès/an sont dus à l'inactivité selon une étude de l'OMS. Vitefit et ses coachs ont à coeur ce sujet et s'engagent à assurer un suivi des membres.\n\n"
              "Engagement : Vibrant fitness for all, une devise qui reflète notre détermination.\n\n"
              "Collaboration : L'épanouissement passe par l'entraide et l'émulation collective.",
            ),
            const SizedBox(height: 20),

            // Lien vers les membres actifs et la mention légale
            Center(
              child: Column(
                children: [
                  // Bouton menant aux membres actifs
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommentairesPage()),
                      );
                    },
                    child: const Text(
                      'Voir nos membres les plus actifs',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Mention légale centrée
                  const Text(
                    '© 2025 Laizé Loucia. Tous droits réservés.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Fonction pour créer un titre de section avec un style spécifique
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent),
      ),
    );
  }

  /// Fonction pour afficher un bloc de texte avec un espacement
  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        content,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }
}

//Les sections sont créées avec les fonctions _buildSectionTitle et _buildSectionContent
// 1 Widget _buildSectionTitle(string title)
// -> Déclare une fonction qui retourne un widget
// Elle prend un paramètre title de type String
// Et définit des propriétés (padding, text, style)
// Ces propriétés seront appliquées dans le corps de SingleCHildScrollView lors de l'appel de la fonction

//2- De même, la fonction _buildSectionContent crée le contenu de la section

// Ca permet de structurer et réutiliser les sections
