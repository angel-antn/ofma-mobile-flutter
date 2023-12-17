import 'package:http/http.dart' as http;
import 'package:ofma_app/data/local/preferences.dart';
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

  Future<String?> resetPasswordRequest({required String email}) async {
    final url = Uri.http(_baseUrl, '$_path/reset-password-request');

    final response = await http.post(url, body: {'email': email});

    if (response.statusCode == 201) {
      return null;
    } else if (response.statusCode == 400) {
      return 'El usuario no se encuentra registrado';
    } else {
      return 'Ha ocurrido un error inesperado';
    }
  }

  Future<String?> validateResetPasswordRequest({
    required String email,
    required String password,
    required String otp,
  }) async {
    final url = Uri.http(_baseUrl, '$_path/validate-reset-password-request');

    final response = await http.post(url,
        body: {'email': email, 'password': password, 'resetPasswordOtp': otp});

    if (response.statusCode == 201) {
      return null;
    } else if (response.statusCode == 400) {
      return 'código de recuperación no válido';
    } else {
      return 'Ha ocurrido un error inesperado';
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

  Future<User?> edit({
    required String name,
    required String lastname,
  }) async {
    final url = Uri.http(_baseUrl, '$_path/${Preferences.user?.id}');

    final response = await http.patch(url, body: {
      'name': name,
      'lastname': lastname,
    }, headers: {
      'Authorization': 'Bearer ${Preferences.token}'
    });

    if (response.statusCode == 200) {
      return User.fromJson(response.body);
    } else {
      return null;
    }
  }
}
