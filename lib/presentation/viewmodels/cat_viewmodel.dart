import 'package:flutter/material.dart';

import '../../domain/entities/cat.dart';
import '../../domain/usecases/get_liked_cats_with_breed.dart';
import '../../domain/repositories/cat_repository.dart';

class CatViewModel extends ChangeNotifier {
  final CatRepository repository;
  final GetLikedCatsWithBreed getLikedCats;

  CatViewModel({
    required this.repository,
    required this.getLikedCats,
  });

  List<Cat> likedCats = [];
  Cat? currentCat;

  bool loading = false;
  String? error;

  Future<void> init() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      likedCats = await getLikedCats();
      await loadCat();
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }

  Future<void> loadCat() async {
    try {
      currentCat = await repository.loadRandomCat();
    } catch (e) {
      error = e.toString();
    }
    notifyListeners();
  }

  Future<void> like() async {
    if (currentCat == null) return;

    loading = true;
    notifyListeners();

    try {
      await repository.saveCat(currentCat!);
      likedCats.add(currentCat!);
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }

  Future<void> remove(Cat cat) async {
    loading = true;
    notifyListeners();

    try {
      await repository.removeCat(cat.id);
      likedCats.remove(cat);
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }
}
