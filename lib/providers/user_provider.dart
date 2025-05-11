import 'package:apartme/controllers/user_controller.dart';
import 'package:apartme/models/user/user_model.dart';
import 'package:flutter/material.dart';

import '../auth/auth_service.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user;

  Future<void> registerUser(
      String name, String phone, String email, String password) async {
    user = await UserController().registerUser(name, phone, email, password)
        as UserModel?;
    notifyListeners();
  }

  Future<void> loginUser(String email, String password) async {
    user = await UserController().loginUser(email, password);
    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    user = await UserController().loginWithGoogle();
    notifyListeners();
  }

  Future<void> logout() async {
    user = await UserController().logout();
    notifyListeners();
  }
}
