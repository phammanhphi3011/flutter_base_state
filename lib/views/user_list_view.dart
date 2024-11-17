import 'package:flutter/material.dart';
import 'package:flutter_bloc/bloc/base_state.dart';
import 'package:flutter_bloc/bloc/bloc_base.dart';
import 'package:flutter_bloc/models/user_model.dart';
import 'package:flutter_bloc/services/api_service.dart';
import 'package:flutter_bloc/viewmodels/user_bloc.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  late UserViewModel _userViewModel;

  @override
  void initState() {
    _userViewModel = UserViewModel(
      apiService: ApiService(baseUrl: 'http://jsonplaceholder.typicode.com'),
    );
    _userViewModel.event.add(FetchUserEvent());
    super.initState();
  }

  @override
  void dispose() {
    _userViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List View USer'),
      ),
      body: StreamBuilder<BaseState>(
        stream: _userViewModel.state,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data is InitialState) {
            return Center(
              child: Text('No data available'),
            );
          } else if (snapshot.data is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data is SuccessState) {
            final users = (snapshot.data as SuccessState<List<UserModel>>).data;
            return ListView.builder(
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.email),
                  subtitle: Text(user.name),
                );
              },
              itemCount: users.length,
            );
          } else if (snapshot.data is ErrorState) {
            return Center(
              child: Text('Error: ${(snapshot.data as ErrorState).message}'),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
