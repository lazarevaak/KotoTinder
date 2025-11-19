import 'package:flutter/material.dart';
import '../models/cat.dart';
import '../services/cat_api_service.dart';

class CatViewModel extends ChangeNotifier {
  final api = CatApiService();

  Cat? currentCat;
  int likes = 0;
  bool loading = false;

  Future<void> loadCat() async {
    loading = true;
    notifyListeners();

    try {
      final data = await api.getRandomCat();
      currentCat = Cat.fromJson(data[0]);
    } catch (e) {
      rethrow;
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
