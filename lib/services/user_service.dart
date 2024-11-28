import 'package:findflow_mobile/models/user_model.dart';
import 'package:findflow_mobile/repos/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String token;
  final User user;
  // user object

  AuthAuthenticated(this.token, this.user);

  @override
  List<Object> get props => [token];
}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}

class AuthService extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final _storage = const FlutterSecureStorage();

  AuthService(this._authRepository) : super(AuthInitial()) {
    _intialAuth();
  }

  Future<void> login(String email, String password) async {
    state = AuthLoading();
    try {
      final token = await _authRepository.authenticate(email, password);
      final user = await _authRepository.getUser(token);

      await _storage.write(key: "token", value: token);
      state = AuthAuthenticated(token, user);
    } catch (e) {
      state = AuthFailure(e.toString());
    }
  }

  Future<void> signUp(
      String email, String password, String name, String? phone) async {
    state = AuthLoading();
    try {
      print("SIGNUP");
      print("$email, $password, $name, $phone");

      final token = await _authRepository.signUp(email, password, name, phone);
      final user = await _authRepository.getUser(token);

      print("TOKEN: $token");
      print("USER: $user");

      await _storage.write(key: "token", value: token);
      state = AuthAuthenticated(token, user);
    } catch (e) {
      state = AuthFailure(e.toString());
    }
  }

  Future<void> _intialAuth() async {
    final token = await _storage.read(key: "token");

    if (token != null) {
      state = AuthLoading();
      try {
        final user = await _authRepository.getUser(token);
        state = AuthAuthenticated(token, user);
      } catch (e) {
        state = AuthInitial();
      }
    } else {
      state = AuthUnauthenticated();
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: "token");
    state = AuthUnauthenticated();
  }
}
