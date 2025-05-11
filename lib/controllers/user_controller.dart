import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../db/db_user_helper.dart';
import '../models/user/user_model.dart';

class UserController {
  Future<UserModel> registerUser(
      String name, String phone, String email, String password) async {
    // get user object from firebase Auth if exists or create new one.
    User firebaseUser = await AuthService.register(email, password);
    print('User From Firebase : ${firebaseUser.uid}');
    // create user object to save it to our database
    final userModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      password: password,
      token: firebaseUser.uid,
      lastLogin: Timestamp.fromDate(firebaseUser.metadata.lastSignInTime!),
    );
    print('User Object : ${userModel.toString()}');
    await DbUserHelper.saveUser(userModel);
    return userModel;
  }

  Future<UserModel> loginUser(String email, String password) async {
    User user = await AuthService.login(email, password);
    // load account from application database
    UserModel? userModel = await DbUserHelper.isUserExist(user.uid);
    return userModel!;
  }

  Future<UserModel?> loginWithGoogle() async {
    User? user = await AuthService.logInWithGoogle();
    if (user != null) {
      String? token = await user.getIdToken(false);
      print('User Token: ${token}');
      // load account from application database
      UserModel? userModel = await DbUserHelper.isUserExist(user.uid);
      if (userModel == null) {
        final userModel = UserModel(
          // uid: firebaseUser.uid,
          name: user.displayName!,
          email: user.email!,
          phone: '',
          // user.phoneNumber!,
          password: "",
          token: user.uid,
          googleToken: token,
          image: user.photoURL,
          lastLogin: Timestamp.fromDate(user.metadata!.lastSignInTime!),
        );
        print('User Object : ${userModel.toString()}');
        await DbUserHelper.saveUser(userModel);
      }
      return userModel!;
    }
    return null;
  }

  Future<UserModel?> logout() async {
    try {
      await AuthService.logout();
      // load account from application database
      return null;
    } catch (error) {
      // todo handel errors
    }
  }
}
