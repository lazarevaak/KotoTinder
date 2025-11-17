class Breed {
  final String id;
  final String name;
  final String origin;
  final String temperament;
  final String description;

  Breed ({
    required this.id,
    required this.name,
    required this.origin,
    required this.temperament,
    required this.description
  });

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      id: json['id'],
      name: json['name'],
      origin: json['origin'],
      temperament: json['temperament'],
      description: json['description']
    );
  }
}