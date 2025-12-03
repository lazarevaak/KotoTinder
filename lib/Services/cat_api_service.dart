import 'dart:convert';
import 'package:http/http.dart' as http;

class CatApiException implements Exception {
  final String message;
  CatApiException(this.message);

  @override
  String toString() => "CatApiException: $message";
}

class CatApiService {
  static const _api = 'https://api.thecatapi.com/v1';

  Future<Map<String, dynamic>> getImageInfo(String id) async {
    try {
      final url = Uri.parse("$_api/images/$id");
      final r = await http.get(url);

      if (r.statusCode != 200) {
        throw CatApiException("Loading error Info: ${r.statusCode}");
      }

      final json = jsonDecode(r.body);
      return json is Map<String, dynamic> ? json : {};
    } catch (e) {
      throw CatApiException("Network Error: $e");
    }
  }

  Future<List<dynamic>> _getRandom() async {
    try {
      final url = Uri.parse("$_api/images/search");
      final r = await http.get(url);

      if (r.statusCode != 200) {
        throw CatApiException("Error loading photo: ${r.statusCode}");
      }

      final json = jsonDecode(r.body);
      return json is List ? json : [];
    } catch (e) {
      throw CatApiException("Network Error: $e");
    }
  }

  Future<Map<String, dynamic>> getRandomCatWithBreed() async {
    final list = await _getRandom();
    if (list.isEmpty || list.first["id"] == null) {
      throw CatApiException("API returned empty list");
    }

    return await getImageInfo(list.first["id"]);
  }

  Future<List<dynamic>> getBreeds() async {
    try {
      final url = Uri.parse("$_api/breeds");
      final r = await http.get(url);

      if (r.statusCode != 200) {
        throw CatApiException("Error loading rocks: ${r.statusCode}");
      }

      final json = jsonDecode(r.body);
      return json is List ? json : [];
    } catch (e) {
      throw CatApiException("Network Error: $e");
    }
  }

  Future<Map<String, dynamic>> getBreed(String id) async {
    final url = Uri.parse("$_api/breeds/$id");
    final r = await http.get(url);

    if (r.statusCode != 200) {
      throw CatApiException("Failed to load breed: ${r.statusCode}");
    }

    final json = jsonDecode(r.body);
    return json is Map<String, dynamic> ? json : {};
  }
}
