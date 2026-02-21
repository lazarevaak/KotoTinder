import 'package:flutter/material.dart';

import '../../domain/entities/breed.dart';
import '../../domain/usecases/get_breeds.dart';
import '../../domain/usecases/search_breeds.dart';

class BreedsViewModel extends ChangeNotifier {
  final GetBreeds getBreeds;
  final SearchBreeds searchBreeds;

  BreedsViewModel({
    required this.getBreeds,
    required this.searchBreeds,
  });

  bool loading = false;
  String? error;

  List<Breed> breeds = [];
  List<Breed> filtered = [];

  Future<void> loadBreeds() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      breeds = await getBreeds();
      filtered = List.from(breeds);
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }

  void search(String query) {
    filtered = searchBreeds(breeds, query);
    notifyListeners();
  }
}