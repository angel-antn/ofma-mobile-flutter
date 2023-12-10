import 'package:http/http.dart' as http;
import 'package:ofma_app/models/user_response.dart';

class UserRequest {
  final String _baseUrl = '10.0.2.2:3000';
  final String _path = '/api/user';

  Future<UserResponse?> login(
      {required String email, required String password}) async {
    final url = Uri.http(_baseUrl, '$_path/login');

    final response =
        await http.post(url, body: {'email': email, 'password': password});

    if (response.statusCode == 201) {
      return UserResponse.fromJson(response.body);
    } else {
      return null;
    }
  }

  Future<UserResponse?> register({
    required String name,
    required String lastname,
    required String email,
    required String password,
  }) async {
    final url = Uri.http(_baseUrl, '$_path/register');

    final response = await http.post(url, body: {
      'name': name,
      'lastname': lastname,
      'email': email,
      'password': password
    });

    if (response.statusCode == 201) {
      return UserResponse.fromJson(response.body);
    } else {
      return null;
    }
  }
}
