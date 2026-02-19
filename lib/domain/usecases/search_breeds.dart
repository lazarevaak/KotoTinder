import '../entities/breed.dart';

class SearchBreeds {
  List<Breed> call(List<Breed> breeds, String query) {
    if (query.isEmpty) return List.from(breeds);

    final q = query.toLowerCase();

    return breeds
        .where(
          (b) =>
              b.name.toLowerCase().contains(q) ||
              b.origin.toLowerCase().contains(q),
        )
        .toList();
  }
}
