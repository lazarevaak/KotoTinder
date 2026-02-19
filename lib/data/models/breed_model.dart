import '../../domain/entities/breed.dart';

class BreedModel {
  final String id;
  final String name;
  final String origin;
  final String temperament;
  final String description;
  final String lifeSpan;

  final int childFriendly;
  final int dogFriendly;
  final int energyLevel;

  const BreedModel({
    required this.id,
    required this.name,
    required this.origin,
    required this.temperament,
    required this.description,
    required this.lifeSpan,
    required this.childFriendly,
    required this.dogFriendly,
    required this.energyLevel,
  });

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
      id: json['id'],
      name: json['name'],
      origin: json['origin'],
      temperament: json['temperament'],
      description: json['description'],
      lifeSpan: json['life_span'],
      childFriendly: json['child_friendly'] ?? 0,
      dogFriendly: json['dog_friendly'] ?? 0,
      energyLevel: json['energy_level'] ?? 0,
    );
  }

  factory BreedModel.fromEntity(Breed breed) {
    return BreedModel(
      id: breed.id,
      name: breed.name,
      origin: breed.origin,
      temperament: breed.temperament,
      description: breed.description,
      lifeSpan: breed.lifeSpan,
      childFriendly: breed.childFriendly,
      dogFriendly: breed.dogFriendly,
      energyLevel: breed.energyLevel,
    );
  }

  Breed toEntity() {
    return Breed(
      id: id,
      name: name,
      origin: origin,
      temperament: temperament,
      description: description,
      lifeSpan: lifeSpan,
      childFriendly: childFriendly,
      dogFriendly: dogFriendly,
      energyLevel: energyLevel,
    );
  }
}
