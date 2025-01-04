import 'package:dio/dio.dart';

class ApiService {
  final String baseUrl = 'https://api.spoonacular.com/recipes';
  final String apiKey = 'db585db8c4c1401d8e9b4154f09073c6';

  final Dio _dio = Dio();

  Future<List<dynamic>> fetchPopularRecipes() async {
    final response = await _dio.get(
      '$baseUrl/random',
      queryParameters: {'apiKey': apiKey, 'number': 10},
    );
    return response.data['recipes'];
  }

  Future<List<dynamic>> searchRecipes(String query) async {
    final response = await _dio.get(
      '$baseUrl/complexSearch',
      queryParameters: {'apiKey': apiKey, 'query': query},
    );
    return response.data['results'];
  }

  Future<Map<String, dynamic>> fetchRecipeDetails(int id) async {
    final response = await _dio.get(
      '$baseUrl/$id/information',
      queryParameters: {'apiKey': apiKey},
    );
    return response.data;
  }
}
