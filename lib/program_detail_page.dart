import 'package:flutter/material.dart';
import 'data_model.dart';

class ProgramDetailPage extends StatelessWidget {
  final ProgramModel
      program; // Indique que la variable program est une constante après son initialisation

//ProgramModel - objet créé à partir des données JSON

  const ProgramDetailPage({Key? key, required this.program}) : super(key: key);

  // *
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Provient des données JSON converties en ProgramModel
        title: Text(program.name ?? "Détails du programme"),
      ),

      // SingleChildScrollView -> défilement du contenu
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image du programme
            program.image != null
                ? Image.asset(
                    'assets/images/${program.image}',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.image_not_supported, size: 200),
            const SizedBox(height: 16),

            // Nom du programme
            Text(
              program.name ?? "Sans nom",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Description
            Text(
              program.description ?? "Pas de description disponible.",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Détails supplémentaires
            Text("Jour : ${program.day}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 5),
            Text("Horaire : ${program.time}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 5),
            Text("Instructeur : ${program.instructor}",
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

//*

// processus données JSON

// 1 - fromJson : Convertit les données JSON en une instance de ProgramModel
//Les données json sont converties en objet/instance de ProgramModel
//via ProgramModel.fromJson. dans le fichier json_model_reader

// 2- l'objet ProgramModel est créé et passé à la page ProgramDetailPage via Navigator.push
//ProgramModel = objet initialisé à partir des données JSON
// via le constructeur fromJson dans le fichier json_model_reader.dart

//3 - ProgramDetailPageProgramDetailPage =  affiche les données en accedant aux attributs de l'objet ProgramModel

//Text(program.name ?? "Détails du programme")
// Affiche le nom du programme ou "Détails du programme" si le nom est null
// Provient des données JSON converties en ProgramModel

//*program.name
//program = objet = instance de ProgramModel (fichier data_model.dart)
//passée à la page ProgramDetailPage
// Dans le constructeur, this.name fait référence à l'attribut name de l'instance de la classe ProgramModel ->   required this.name,
//a page affiche ces données en les appelant via leur attribut en se référant au modèle

//.name
// Acès à l'attribut
// On utilise le point (.) pour accéder à l'attribut name de l'objet program

//?? "Détails du programme"
//Opérateur de coalescence nulle
//Si program.name est null, affiche "Détails du programme"
