import '../repositories/cat/cat_repository.dart';

class RemoveCat {
  final CatRepository repository;

  RemoveCat(this.repository);

  Future<void> call(String id) {
    return repository.removeCat(id);
  }
}