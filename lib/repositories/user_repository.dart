import 'dart:convert';

import 'package:flutter_bloc/models/user_model.dart';
import 'package:flutter_bloc/services/api_service.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final ApiService apiService;

  UserRepository({required this.apiService});
  //Call API get user
  Future<List<UserModel>> fetchUsers() async {
    final jsonData = await apiService.get('/users');
    return jsonData.map((e) => UserModel.fromJson(e)).toList();
  }
}
