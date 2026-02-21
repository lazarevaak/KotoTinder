import '../entities/cat.dart';
import '../repositories/cat/cat_repository.dart';

class LikeCat {
  final CatRepository repository;

  LikeCat(this.repository);

  Future<void> call(Cat cat) {
    return repository.saveCat(cat);
  }
}