import '../../entities/cat.dart';
import '../../entities/breed.dart';

import 'cat_repository.dart';

import '../../../data/datasources/remote/cat_remote_datasource.dart';
import '../../../data/datasources/local/cat_local_datasource.dart';

import '../../../data/models/cat_model.dart';

class CatRepositoryImpl implements CatRepository {
  final CatRemoteDataSource remote;
  final CatLocalDataSource local;

  CatRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<Cat> loadRandomCat() async {
    final model = await remote.loadRandomCat();
    return model.toEntity();
  }

  @override
  Future<void> saveCat(Cat cat) async {
    final model = CatModel.fromEntity(cat);
    await local.saveCat(model);
  }

  @override
  List<Cat> loadSavedCats() {
    return local.loadSavedCats()
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<void> removeCat(String id) {
    return local.removeCat(id);
  }

  @override
  Future<Breed?> loadBreed(String? id) async {
    if (id == null) return null;

    final model = await remote.loadBreed(id);
    return model.toEntity();
  }

  @override
  Future<List<Breed>> loadBreeds() async {
    final models = await remote.loadBreeds();
    return models.map((m) => m.toEntity()).toList();
  }
}


