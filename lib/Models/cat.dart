import 'breed.dart';

class Cat {
  final String id;
  final String url;
  final int width;
  final int height;

  final String? breedID;
  final String? breedName;

  final Breed? fullBreed; // <— добавили

  Cat({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
    this.breedID,
    this.breedName,
    this.fullBreed,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    final breeds = json['breeds'] as List<dynamic>?;

    final breedJson =
        (breeds != null && breeds.isNotEmpty) ? breeds[0] : null;

    return Cat(
      id: json['id'],
      url: json['url'],
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      breedID: breedJson?['id'],
      breedName: breedJson?['name'],
      fullBreed: breedJson != null ? Breed.fromJson(breedJson) : null,
    );
  }
}
