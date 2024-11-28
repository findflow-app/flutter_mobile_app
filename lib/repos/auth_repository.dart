import 'package:dio/dio.dart';
import 'package:findflow_mobile/models/user_model.dart';

class AuthRepository {
  final Dio _dio;
  AuthRepository(this._dio);

  Future<String> authenticate(String email, String password) async {
    try {
      final response = await _dio.post('/login', data: {
        'email': email,
        'password': password,
      });

      print("Authenticated");

      if (response.statusCode == 200) {
        print("AUTH RESPONSE");
        print(response.data);
        return response.data['token'];
      } else {
        print(response);
        throw Exception('Failed to authenticate');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to authenticate');
    }
  }

  Future<User> getUser(String token) async {
    final response = await _dio.post('/auth', data: {
      'token': token,
    });

    if (response.statusCode == 200) {
      print("USER RESPONSE");
      Map<String, dynamic> data = response.data; // as Map<String, dynamic>;

      return User(id: data['id'], name: data['name'], email: data['email']);
    } else {
      print(response);
      throw Exception('Failed to get user');
    }
  }

  Future<String> signUp(
      String email, String password, String name, String? phone) async {
    final response = await _dio.post('/signup', data: {
      'email': email,
      'password': password,
      'name': name,
      'phone_number': phone,
    });

    if (response.statusCode == 200) {
      print("SIGNUP RESPONSE");
      print(response.data);
      return response.data['token'];
    } else {
      print(response);
      throw Exception('Failed to sign up');
    }
  }
}
