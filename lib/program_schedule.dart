import 'package:flutter/material.dart';
import 'json_model_reader.dart';
import 'data_model.dart';
import 'program_detail_page.dart';

//Declaration de la classe ProgramSchedul
class ProgramSchedule extends StatefulWidget {
  const ProgramSchedule({super.key});

  @override
  ProgramScheduleState createState() =>
      ProgramScheduleState(); //Creation de l'état associé
}

// *
//Déclaration de la classe d'état ProgramScheduleState (gère l'état de la classe ProgramSchedule)

// La classe futurePrograms déclare une variable de type Future qui contiendra une liste de ProgramModel
//Cette liste est sera déclarée dans le fichier du modèle des données récupérées en local dans le fichier json
//un Future est un objet qui représente une valeur ou une erreur
//qui sera disponible à un moment dans le futur.
// = manière de gérer des opérations asynchrones
// ->comme la lecture de données depuis un fichier ou une API

class ProgramScheduleState extends State<ProgramSchedule> {
  late Future<List<ProgramModel>> futurePrograms;

//on cree l'objet futur qui contiendra les données et on l'initialise avec la méthode initState
  // La méthode initState est appelée lors de l'initialisation de l'état
// Cette méthode initialise l'état et lit les données du fichier JSON
  @override
  void initState() {
    super.initState(); // Appelle l'initialisation de la classe parente
    futurePrograms = readProgramJsonData(); // Reader pour program.json
    //Initialise futurePrograms en lisant les données du fichier program.json
    // et les assigne à futurePrograms
  }

//****************************************************
//ProgramSchedule - widget avec état
//ProgramScheduleState - gère l'état de ProgramSchedule
//futurePrograms - contient les données lues de program.json
//ProgramModel - objet créé à partir des données JSON
//Future - opération asynchrone qui récupère et convertit les données JSON
//initState initialise l'état et lit les données
//******************************************************

//*******************************************************
//builder : Fonction qui construit l'interface utilisateur en fonction de l'état du Future.
//context : Informations sur l'emplacement du widget dans l'arbre des widgets.
//snapshot : Contient les données et l'état du Future.
//********************************************************

//**
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
              "Programme des Cours")), //Ajoute une barre d'application en haut de l'écran avec un titre
      body: FutureBuilder<List<ProgramModel>>(
        future:
            futurePrograms, // objet Future qui contient les données asynchrones
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucun cours trouvé"));
          }

          //***
          List<ProgramModel> programs = snapshot
              .data!; //programs : liste des données du programme obtenue à partir des données du snapshot
          return ListView.builder(
            itemCount: programs.length,
            itemBuilder: (context, index) {
              final program = programs[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: program.image != null
                      ? Image.asset(
                          'assets/images/${program.image}', //${program.image} insère la valeur de program.image dans la chaîne de caractères.
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.image_not_supported, size: 60),
                  title: Text(program.name ?? "Sans nom"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // aligne les enfants de la colonne à gauche

                    children: [
                      Text("Jour : ${program.day ?? "Non specifie"}"),
                      Text("Horaire : ${program.time ?? "Non specifie"}"),
                      Text(
                          "Instructeur : ${program.instructor ?? "Non specifie"}"),
                    ],
                  ),

                  // ****
                  onTap: () {
                    // Naviguer vers la page dédiée avec les détails du programme
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProgramDetailPage(program: program),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

//*

//initState
// déclaration de la méthode initState
// C'est une méthode spéciale pour les widgets avec état actif
//  Elle est appelée une seule fois lors de l'initialisation de l'état du widget

// super.initState(); :
//appelle la méthode initState de la classe parente State
// = vérifie que toute initialisation faite dans la classe parente est exécutée

//readProgramJsonData() : Cette fonction lit les données du fichier program.json
//et retourne les données
// futurePrograms = readProgramJsonData(); :
//assigne le résultat de la fonction readProgramJsonData() à la variable futurePrograms

// **

// Le widget FutureBuilder<List> est un widget construiT l'UI selon l'état de futurePrograms
// Il prend 2 arguments : future et builder
// 1 futur : =  propriété du FutureBuilder qui attend un objet de type Future -> le Future utilisé pour obtenir les données
// 2 futurePrograms =  l'objet future qui est passé à la propriété future
// Cet objet représente une opération asynchrone qui renverra une liste de ProgramModel, modèle des dnnées json

// builder fonction et propriété du FutureBuilder
// Elle prend une fonction
// Cette fonction est appelée chaque fois que l'état du Future change
// Elle construit l'UI selon l'état actuel du Future.

//(context, snapshot) =  paramètres de la fonction builder
// -context =   contient des informations sur l'emplacement du widget dans l'arbre des widgets (thèmes et les localisations)
// -snapshot =  contient les informations sur l'état instantané du Future

// snapshot a plusieurs propriétés :
//snapshot.connectionState = indique l'état de la connexion au Future (avec des valeurs none, waiting, done...)
//snapshot.hasError = indique si il y an erreur avec le Future
//snapshot.error = contient l'erreur si snapshot.hasError est vrai
//snapshot.hasData : indique si le Future a renvoyé des données
//snapshot.data : contient les données renvoyées par le Future

// les conditions de la fonction builder
// En lien avec le paramètre snapshot
//1 snapshot.connectionState == ConnectionState.waiting : si le Future est en cours d'execution, affiche un indicateur de progression
//2 snapshot.hasError : si le Future a rencontré une erreur, un message d'erreur est affiché
//3 !snapshot.hasData || snapshot.data!.isEmpty : si le Future est terminé mais ne contient pas de données, un message indique qu'aucun cours n'a été trouvé.

// ***

//*****************************************************************************
//programs : liste des programmes obtenue à partir des données du snapshot
//ListView.builder : crée une liste déroulante d'éléments
//Card - afficher pour chaque élément de la liste
//ListTile : affiche une ligne avec une image, un titre et un sous-titre pour chaque élément de la list tirées des données json
//*******************************************************************************

// Ligne  List<ProgramModel> programs = snapshot.data!;
////List programs : déclare une variable programs de type List<ProgramModel>,
//càd une liste d'objets tirées de ProgramModel
//programs =  variable contenant la liste d'objets ProgramModel obtenue à partir des données du snapshot
//snapshot.data! = les données du Future disponibles pour l'affichage affectées à programs

//snapshot - parametre de la fonction builder qui contient les informations sur l'état actuel du Future
//data - propriete de snapshot qui contient les données renvoyées par le Future une fois qu'il est complété
// "!" =  données pas nulles / opérateur de nullité forcée

// Widget ListView.builder
//itemCount =  programs.length = le nb d'éléments de la liste programs via la varibale
//itemBuilder = (context, index) = fonction qui construit chaque élément de la liste. Elle prend deux paramètres :
//context = le BuildContext de l'élément
//index = l'index de l'élément dans la liste
//final program = programs[index];
//program = l'element actuel de la liste programs dans l'index donné

//Widget ListTile :
//affiche une ligne avec une icône principale, un titre, et un sous-titre
// 1 - leading: program.image != null ? Image.asset(...) = const Icon(Icons.image_not_supported, size: 60)
//affiche une image si program.image n'est pas null, sinon une icône par défaut
// 2 - title: Text(program.name ?? "Sans nom") =  affiche le nom du programme ou "Sans nom" si le nom est null
//subtitle: Column(...) = affiche des informations supplémentaires sous le titre.
// 3- children = [Text("Jour : ${program.day ?? "Non spécifié"}"), Text("Horaire : ${program.time ?? "Non spécifié"}"), Text("Instructeur : ${program.instructor ?? "Non spécifié"}")]
// = affiche le jour, l'horaire et l'instructeur du programme, ou "non spécifié" si ces informations sont nulles

// interpolation de chaînes
//${program.image}
// Syntaxe permettant d'insérer la valeur de program.image dans la chaîne de caractères
// ($){} = insérer le résultat dans la chaîne

// ****

//**********************************************************************
//onTap - déclenche l'action de navigation lorsqu'on tape sur l'élément.
//Navigator.push - navigue vers une nouvelle page
//context - donne le contexte de l'emplacement actuel du widget
//MaterialPageRoute - définit la route de navigation avec une transition
//builder -  construit la nouvelle page avec les détails du programme
//**********************************************************************

//fonction onTap: () {}
// Propriété de ListTile qui définit l'action à effectuer lorsqu'on tape sur cette ligne
// Appelée lorsqu'on tape sur l'élément

//Navigator.push
//naviguer vers une nouvelle page
//Méthode de la classe Navigator qui gère la navigation entre les pages

//context
//Fournit le contexte de l'emplacement actuel du widget dans l'arbre des widgets
//Paramètre requis par Navigator.push pour savoir où insérer la nouvelle page dans l'arbre des widgets

//MaterialPageRoute
// Classe utilisée pour définir la nouvelle page a afficher
//Crée une route de navigation

//builder: (context) => ProgramDetailPage(program: program)
//Fonction qui construit la nouvelle page ProgramDetailPage avec les détails du programme
//Propriété de MaterialPageRoute qui définit la page à afficher
//program: program : passe l'objet program à la nouvelle page pour afficher ses détails
// - 1er program : paramètre du constructeur de ProgramDetailPage
// - 2e program : variable locale contenant l'objet ProgramModel actuel
