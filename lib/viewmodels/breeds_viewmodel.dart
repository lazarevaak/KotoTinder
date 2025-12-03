import 'package:flutter/material.dart';
import '../services/cat_api_service.dart';
import '../models/breed.dart';

class BreedsViewModel extends ChangeNotifier {
  final api = CatApiService();

  bool loading = false;
  String? error;

  List<Breed> breeds = [];
  List<Breed> filtered = [];

  Future<void> loadBreeds() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      final data = await api.getBreeds();

      breeds = data.map((e) => Breed.fromJson(e)).toList();
      filtered = List.from(breeds);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      filtered = List.from(breeds);
    } else {
      final q = query.toLowerCase();
      filtered = breeds
          .where(
            (b) =>
                b.name.toLowerCase().contains(q) ||
                b.origin.toLowerCase().contains(q),
          )
          .toList();
    }

    notifyListeners();
  }
}
