import 'package:hive/hive.dart';

import '../models/cat.dart';
import '../models/breed.dart';
import '../storage/cat_hive_model.dart';
import '../services/cat_api_service.dart';

class CatRepository {
  final CatApiService api;

  late Box<CatHiveModel> box;

  CatRepository({required this.api});

  Future<void> init() async {
    box = Hive.box<CatHiveModel>('liked_cats');
  }

  Future<Cat> loadRandomCat() async {
    final json = await api.getRandomCatWithBreed();
    return Cat.fromJson(json);
  }

  Future<void> saveCat(Cat cat) async {
    await box.put(
      cat.id,
      CatHiveModel(
        id: cat.id,
        url: cat.url,
        breedName: cat.breedName,
        breedID: cat.breedID,
      ),
    );
  }

  List<Cat> loadSavedCats() {
    return box.values.map((h) {
      return Cat(
        id: h.id,
        url: h.url,
        width: 0,
        height: 0,
        breedID: h.breedID,
        breedName: h.breedName,
        fullBreed: null,
      );
    }).toList();
  }

  Future<void> removeCat(String id) async {
    await box.delete(id);
  }

  Future<Breed?> loadBreed(String? id) async {
    if (id == null) return null;

    final json = await api.getBreed(id);
    return Breed.fromJson(json);
  }
}
