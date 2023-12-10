import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  final loginFormKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool isValidForm() => loginFormKey.currentState?.validate() ?? false;

  clear() {
    email = '';
    password = '';
  }
}
