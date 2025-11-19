import 'package:flutter/material.dart';
import '../services/cat_api_service.dart';
import '../models/breed.dart';

class BreedsViewModel extends ChangeNotifier {
  final api = CatApiService();

  bool loading = false;
  List<Breed> breeds = [];

  Future<void> loadBreeds() async {
    loading = true;
    notifyListeners();

    try {
      final data = await api.getBreeds();
      breeds = data.map((e) => Breed.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
