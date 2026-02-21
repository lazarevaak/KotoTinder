import 'package:flutter/material.dart';

import '../../domain/entities/cat.dart';

import '../../domain/usecases/init_cats.dart';
import '../../domain/usecases/get_random_cat.dart';
import '../../domain/usecases/like_cat.dart';
import '../../domain/usecases/remove_cat.dart';

class CatViewModel extends ChangeNotifier {
  final InitCats initCats;
  final GetRandomCat getRandomCat;
  final LikeCat likeCat;
  final RemoveCat removeCat;

  CatViewModel({
    required this.initCats,
    required this.getRandomCat,
    required this.likeCat,
    required this.removeCat,
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
      final result = await initCats();
      likedCats = result.liked;
      currentCat = result.random;
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }

  Future<void> loadCat() async {
    try {
      currentCat = await getRandomCat();
    } catch (e) {
      error = e.toString();
    }
    notifyListeners();
  }

  Future<void> like() async {
    if (currentCat == null) return;

    try {
      await likeCat(currentCat!);
      likedCats.add(currentCat!);
    } catch (e) {
      error = e.toString();
    }

    notifyListeners();
  }

  Future<void> remove(Cat cat) async {
    try {
      await removeCat(cat.id);
      likedCats.remove(cat);
    } catch (e) {
      error = e.toString();
    }

    notifyListeners();
  }
}