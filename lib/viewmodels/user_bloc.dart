import 'dart:async';

import 'package:flutter_bloc/bloc/base_event.dart';
import 'package:flutter_bloc/bloc/base_state.dart';
import 'package:flutter_bloc/bloc/bloc_base.dart';
import 'package:flutter_bloc/models/user_model.dart';
import 'package:flutter_bloc/repositories/user_repository.dart';
import 'package:flutter_bloc/services/api_service.dart';

class FetchProductEvent extends BaseEvent {}

class UserViewModel extends BaseBloc<FetchProductEvent, BaseState> {
  final ApiService apiService;
  UserViewModel({required this.apiService});
  final UserRepository _userRepository = UserRepository(apiService: apiServer);

  //Method get users

  @override
  Future<BaseState> mapEventToState(FetchProductEvent event) async {
    emit(LoadingState()); //Loading
    try {
      final users = await _userRepository.fetchUsers();
      return SuccessState<List<UserModel>>(users);
    } catch (e) {
      return ErrorState('Error fetching products: $e');
    }
  }
}
