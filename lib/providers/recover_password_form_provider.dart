import 'package:flutter/material.dart';

class RecoverPasswordFormProvider extends ChangeNotifier {
  final recoverPasswordFormKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String repeatedPassword = '';

  bool isValidForm() =>
      recoverPasswordFormKey.currentState?.validate() ?? false;

  clear() {
    email = '';
    password = '';
    repeatedPassword = '';
  }
}
