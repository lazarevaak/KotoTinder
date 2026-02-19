import '../entities/cat.dart';
import '../entities/breed.dart';

abstract class CatRepository {
  Future<Cat> loadRandomCat();
  Future<void> saveCat(Cat cat);
  List<Cat> loadSavedCats();
  Future<void> removeCat(String id);
  Future<Breed?> loadBreed(String? id);
  Future<List<Breed>> loadBreeds();
}

