import '../../models/cat_model.dart';
import '../../models/breed_model.dart';

import '../../datasources/services/cat_api_service.dart';

class CatRemoteDataSource {
  final CatApiService api;

  CatRemoteDataSource(this.api);

  Future<CatModel> loadRandomCat() async {
    final json = await api.getRandomCatWithBreed();
    return CatModel.fromJson(json);
  }

  Future<BreedModel> loadBreed(String id) async {
    final json = await api.getBreed(id);
    return BreedModel.fromJson(json);
  }

  Future<List<BreedModel>> loadBreeds() async {
    final data = await api.getBreeds();
    return data
        .map<BreedModel>((e) => BreedModel.fromJson(e))
        .toList();
  }
}
