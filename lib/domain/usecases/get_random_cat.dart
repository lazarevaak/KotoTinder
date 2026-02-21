import '../entities/cat.dart';
import '../repositories/cat/cat_repository.dart';

class GetRandomCat {
  final CatRepository repository;

  GetRandomCat(this.repository);

  Future<Cat> call() {
    return repository.loadRandomCat();
  }
}