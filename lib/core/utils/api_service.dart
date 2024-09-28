import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final _baseUrl = dotenv.env['apiLink'];
  final Dio dio;
  ApiService(this.dio);
  Future<dynamic> get(String endpoint, String query) async {
    var response = await dio.get('$_baseUrl$endpoint?$query');
    return response.data;
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> query) async {
    var response = await dio.post(
      '$_baseUrl$endpoint',
      data: jsonEncode(query),
      options: Options(
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      ),
    );
    if (response.statusCode == 200) {
      return response.data;
    }
  }
}
