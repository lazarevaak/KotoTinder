import 'dart:convert';
import 'package:http/http.dart' as http;

class CatApiService {
  static const _api = 'https://api.thecatapi.com/v1';

  // MARK: - Получение инфы о фото
  Future<Map<String, dynamic>> getImageInfo(String id) async {
    final url = Uri.parse("$_api/images/$id");
    final r = await http.get(url);

    if (r.statusCode != 200) {
      throw Exception("Ошибка загрузки Info");
    }

    return jsonDecode(r.body);
  }

  // MARK: - Случайное фото (без породы)
  Future<List<dynamic>> _getRandom() async {
    final url = Uri.parse("$_api/images/search");
    final r = await http.get(url);

    if (r.statusCode != 200) {
      throw Exception("Ошибка загрузки фото");
    }

    return jsonDecode(r.body);
  }

  // MARK: - Случайный кот с полной информацией о породе
  Future<Map<String, dynamic>> getRandomCatWithBreed() async {
    final list = await _getRandom();
    final id = list.first["id"];

    return await getImageInfo(id);
  }

  // MARK: - Загрузка всех пород
  Future<List<dynamic>> getBreeds() async {
    final url = Uri.parse("$_api/breeds");
    final r = await http.get(url);

    if (r.statusCode != 200) {
      throw Exception("Ошибка загрузки пород");
    }

    return jsonDecode(r.body);
  }
}
