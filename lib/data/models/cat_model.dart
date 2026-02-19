import '../../domain/entities/cat.dart';

import 'breed_model.dart';

class CatModel {
  final String id;
  final String url;
  final int width;
  final int height;

  final String? breedID;
  final String? breedName;
  final BreedModel? fullBreed;

  const CatModel({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
    this.breedID,
    this.breedName,
    this.fullBreed,
  });

  factory CatModel.fromEntity(Cat cat) {
    return CatModel(
      id: cat.id,
      url: cat.url,
      width: cat.width,
      height: cat.height,
      breedID: cat.breedID,
      breedName: cat.breedName,
      fullBreed: cat.fullBreed != null
          ? BreedModel.fromEntity(cat.fullBreed!)
          : null,
    );
  }

  factory CatModel.fromJson(Map<String, dynamic> json) {
    final breeds = json['breeds'] as List<dynamic>?;

    final breedJson =
        (breeds != null && breeds.isNotEmpty) ? breeds[0] : null;

    return CatModel(
      id: json['id'],
      url: json['url'],
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      breedID: breedJson?['id'],
      breedName: breedJson?['name'],
      fullBreed:
          breedJson != null ? BreedModel.fromJson(breedJson) : null,
    );
  }

  Cat toEntity() {
    return Cat(
      id: id,
      url: url,
      width: width,
      height: height,
      breedID: breedID,
      breedName: breedName,
      fullBreed: fullBreed?.toEntity(),
    );
  }

  
}
