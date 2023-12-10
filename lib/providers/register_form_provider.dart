import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  final registerFormKey = GlobalKey<FormState>();

  String name = '';
  String lastname = '';
  String email = '';
  String password = '';
  String repeatedPassword = '';

  bool isValidForm() => registerFormKey.currentState?.validate() ?? false;

  clear() {
    name = '';
    lastname = '';
    email = '';
    password = '';
    repeatedPassword = '';
  }
}
