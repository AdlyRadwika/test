import 'package:practical_test/data/model/university/university.dart';
import 'package:dio/dio.dart';

class UniversityRepository {
  final Dio client;

  UniversityRepository({
    required this.client,
  });

  static const String _baseUrl = 'http://universities.hipolabs.com/search?country=indonesia';
  static const String _name = 'name';
  static const String _offset = 'offset';
  static const String _limit = 'limit=10';

  Future<List<UniversityModel>> getUniversityList({int page = 0}) async {
    final response = await client.get("$_baseUrl&$_limit&$_offset=$page");
    if (response.statusCode == 200) {
      final json = response.data;
      List<UniversityModel> data = (json as List).map((item) => UniversityModel.fromJson(item)).toList();
      return data;
    } else {
      throw Exception('Failed to load the University List');
    }
  }

  Future<List<UniversityModel>> searchUniversity({required String query, int page = 0}) async {
    print('query: $query');
    final response = await client.get("$_baseUrl&$_name=$query&$_limit&$_offset=$page");
    if (response.statusCode == 200) {
      print(response);
      final json = response.data;
      List<UniversityModel> data = (json as List).map((item) => UniversityModel.fromJson(item)).toList();
      return data;
    } else {
      throw Exception(
          'The university you are trying to look for is not found, start by searching the correct name.');
    }
  }
}