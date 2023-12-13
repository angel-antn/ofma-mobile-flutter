import 'package:flutter/material.dart';
import 'package:ofma_app/data/local/preferences.dart';
import 'package:ofma_app/models/user_response.dart';

class UserDataProvider extends ChangeNotifier {
  User? user = Preferences.user;

  clear() {
    user = null;
  }

  updateUser(User user) {
    this.user = user;
    notifyListeners();
  }
}
