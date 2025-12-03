import 'package:flutter/material.dart';
import '../models/cat.dart';
import '../repository/cat_repository.dart';

class CatViewModel extends ChangeNotifier {
  final CatRepository repo;

  CatViewModel({required this.repo});

  List<Cat> likedCats = [];
  Cat? currentCat;

  bool loading = false;
  String? error;

  Future<void> init() async {
    await repo.init();

    likedCats = repo.loadSavedCats();

    for (int i = 0; i < likedCats.length; i++) {
      final breed = await repo.loadBreed(likedCats[i].breedID);
      likedCats[i] = likedCats[i].copyWith(fullBreed: breed);
    }

    await loadCat();

    notifyListeners();
  }

  Future<void> loadCat() async {
    loading = true;
    notifyListeners();

    try {
      currentCat = await repo.loadRandomCat();
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }

  Future<void> like() async {
    if (currentCat == null) return;

    likedCats.add(currentCat!);
    notifyListeners();

    await repo.saveCat(currentCat!);
  }

  Future<void> remove(Cat cat) async {
    likedCats.remove(cat);
    notifyListeners();

    await repo.removeCat(cat.id);
  }
}
