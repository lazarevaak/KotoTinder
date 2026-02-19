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

  const Breed({
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

  static fromJson(e) {}
}
