// Définition du modèle RoomModel qui représente une salle
// attributs de l'objet
class RoomModel {
  String? name; // Nom de la salle (peut être null)
  String? image;
  String? address;
  String? openingHours;

  // Constructeur avec paramètres optionnels
  RoomModel({
    this.name,
    this.image,
    this.address,
    this.openingHours,
  });

  // Factory constructor pour créer une instance de RoomModel à partir d'un JSON
  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      name: json['name'] as String?,
      image: json['image'] as String?,
      address: json['address'] as String?,
      openingHours: json['opening_hours'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'address': address,
      'opening_hours': openingHours,
    };
  }
}

//attributs de l'objet
class ProgramModel {
  final String name;
  final String day;
  final String time;
  final String description;
  final String instructor;
  final String image;

  ProgramModel({
    required this.name,
    required this.day,
    required this.time,
    required this.description,
    required this.instructor,
    required this.image,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json) {
    return ProgramModel(
      name: json['name'] as String,
      day: json['day'] as String,
      time: json['time'] as String,
      description: json['description'] as String,
      instructor: json['instructor'] as String,
      image: json['image'] as String,
    );
  }
}
//Attributs : Stockent les informations sur le programme
//Constructeur nommé : Initialise les attributs avec des valeurs données
//Constructeur factory fromJson : Convertit un objet JSON en une instance de ProgramModel

//as
//Opérateur de cast
//Convertit une valeur d'un type à un autre type spécifié

// le Factory Constructor est un constructeur
//  qui retourne soit une nouvelle instance basée sur des données
// spécifiques, lors de la conversion JSON en objet avec la méthode
// fromjson ou on utilise Map<String, dynamic> pour représenter les données JSON ->dans le ficheir json_model_reader.dart
