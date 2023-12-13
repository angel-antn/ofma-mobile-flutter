import 'package:flutter/material.dart';
import 'package:ofma_app/data/local/preferences.dart';

class EditProfileFormProvider extends ChangeNotifier {
  final editProfileFormKey = GlobalKey<FormState>();

  String name = Preferences.user?.name ?? '';
  String lastname = Preferences.user?.lastname ?? '';

  bool isValidForm() => editProfileFormKey.currentState?.validate() ?? false;

  clear() {
    name = Preferences.user?.name ?? '';
    lastname = Preferences.user?.lastname ?? '';
  }
}
