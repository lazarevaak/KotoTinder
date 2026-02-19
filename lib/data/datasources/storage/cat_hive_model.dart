import 'package:hive/hive.dart';

part 'cat_hive_model.g.dart';

@HiveType(typeId: 1)
class CatHiveModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String url;

  @HiveField(2)
  String? breedName;

  @HiveField(3)
  String? breedID;

  CatHiveModel({
    required this.id,
    required this.url,
    this.breedName,
    this.breedID,
  });
}
