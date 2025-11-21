import 'package:flutter/material.dart';
import '../models/cat.dart';
import '../services/cat_api_service.dart';

class CatViewModel extends ChangeNotifier {
  final _api = CatApiService();

  bool loading = false;
  Cat? currentCat;
  int likes = 0;

  Future<void> loadCat() async {
    loading = true;
    notifyListeners();

    try {
      final json = await _api.getRandomCatWithBreed();
      currentCat = Cat.fromJson(json);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void like() {
    likes++;
    notifyListeners();
  }
}
