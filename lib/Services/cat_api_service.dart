import 'dart:convert';
import 'package:http/http.dart' as http;

/// Сервис для работы с TheCatAPI.
class CatApiService {
  /// Базовый URL API.
  static const _api = 'https://api.thecatapi.com/v1';

  // MARK: - Фото котика 

  /// Загружает случайного котика.
  ///
  /// Возвращает список объектов. Генерирует ошибку, если статус ответа не 200.
  Future<List<dynamic>> getRandomCat() async {
    final url = Uri.parse("$_api/images/search");
    final r = await http.get(url);

    if (r.statusCode != 200) {
      throw Exception("Ошибка загрузки фото котика");
    }

    return jsonDecode(r.body);
  }

  // MARK: - Породы

  /// Загружает список пород котов.
  ///
  /// Возвращает массив пород. Генерирует ошибку при любом статусе, кроме 200.
  Future<List<dynamic>> getBreeds() async {
    final url = Uri.parse("$_api/breeds");
    final r = await http.get(url);

    if (r.statusCode != 200) {
      throw Exception("Ошибка загрузки породы");
    }

    return jsonDecode(r.body);
  }
}
