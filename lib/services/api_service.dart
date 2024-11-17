import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<dynamic>> get(String entpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl$entpoint'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

final apiServer = ApiService(baseUrl: 'http://jsonplaceholder.typicode.com');
