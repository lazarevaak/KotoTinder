import '../entities/breed.dart';
import '../repositories/cat/cat_repository.dart';

class GetBreeds {
  final CatRepository repository;

  GetBreeds(this.repository);

  Future<List<Breed>> call() {
    return repository.loadBreeds();
  }
}