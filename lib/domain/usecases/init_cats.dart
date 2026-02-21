import '../entities/cat.dart';
import 'get_liked_cats_with_breed.dart';
import 'get_random_cat.dart';

class InitCatsResult {
  final List<Cat> liked;
  final Cat random;

  InitCatsResult({
    required this.liked,
    required this.random,
  });
}

class InitCats {
  final GetLikedCatsWithBreed getLikedCats;
  final GetRandomCat getRandomCat;

  InitCats(
    this.getLikedCats,
    this.getRandomCat,
  );

  Future<InitCatsResult> call() async {
    final liked = await getLikedCats();
    final random = await getRandomCat();

    return InitCatsResult(
      liked: liked,
      random: random,
    );
  }
}