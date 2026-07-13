import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../errors/exceptions.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl$endpoint'));
      return _handleResponse(response);
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('An unexpected error occurred: $e');
    }
  }

  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 404:
        throw NotFoundException();
      case 500:
        throw ServerException();
      default:
        throw ApiException('Error occurred with status code: ${response.statusCode}');
    }
  }
}
