import '../entities/cat.dart';
import '../repositories/cat_repository.dart';

class GetLikedCatsWithBreed {
  final CatRepository repository;

  GetLikedCatsWithBreed(this.repository);

  Future<List<Cat>> call() async {
    final cats = await repository.loadSavedCats();

    return Future.wait(
      cats.map((cat) async {
        final breed = await repository.loadBreed(cat.breedID);
        return cat.copyWith(fullBreed: breed);
      }),
    );
  }
}
