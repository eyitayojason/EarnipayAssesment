import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/constants.dart';
import '../models/fetch_photo_model.dart';

class ApiService {
  Future<List<Photo>> fetchPhotos({int page = 1, int perPage = 20}) async {
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/photos?page=$page&per_page=$perPage'),
      headers: {'Authorization': 'Client-ID ${Constants.apiKey}'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Photo.fromJson(item)).toList();
    } else {
      throw Exception(
          'Failed to fetch photos. Status code: ${response.statusCode}');
    }
  }
}
