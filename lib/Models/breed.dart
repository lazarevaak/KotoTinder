class Breed {
  final String id;
  final String name;
  final String origin;
  final String temperament;
  final String description;
  final String lifeSpan;

  final int childFriendly;
  final int dogFriendly;
  final int energyLevel;

  Breed({
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

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
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
}
