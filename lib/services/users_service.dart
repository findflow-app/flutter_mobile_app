import 'package:findflow_mobile/models/user_model.dart';
import 'package:findflow_mobile/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_service.g.dart';

sealed class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<UserLow> users;
  UsersLoaded(this.users);
}

class UsersError extends UsersState {
  final String message;
  UsersError(this.message);
}

@riverpod
class UsersService extends _$UsersService {
  @override
  UsersState build() => UsersInitial();

  Future<void> fetchUserLow(String name) async {
    final dio = ref.read(dioProvider);
    state = UsersLoading();
    const storage = FlutterSecureStorage();

    final token = await storage.read(key: 'token');

    final response = await dio.post('/search', data: {
      'token': token,
      'name_string': name,
    });

    List<UserLow> users = (response.data['result'] as List)
        .map((e) => UserLow(id: e[0], name: e[1]))
        .toList();

    state = UsersLoaded(users);
  }
}
