import 'package:hive/hive.dart';
import '../../models/cat_model.dart';
import '../../datasources/storage/cat_hive_model.dart';

class CatLocalDataSource {
  final Box<CatHiveModel> box;

  CatLocalDataSource(this.box);

  Future<void> saveCat(CatModel cat) async {
    await box.put(
      cat.id,
      CatHiveModel(
        id: cat.id,
        url: cat.url,
        breedName: cat.breedName,
        breedID: cat.breedID,
      ),
    );
  }

  List<CatModel> loadSavedCats() {
    return box.values.map((h) {
      return CatModel(
        id: h.id,
        url: h.url,
        width: 0,
        height: 0,
        breedID: h.breedID,
        breedName: h.breedName,
      );
    }).toList();
  }

  Future<void> removeCat(String id) async {
    await box.delete(id);
  }
}
