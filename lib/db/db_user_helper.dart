import 'package:apartme/db/db_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user/user_model.dart';

class DbUserHelper extends DbHelper {
  // User Table Columns Keys
  static const String DB_USER_TABLE_ID_KEY = "uid";
  static const String DB_USER_TABLE_NAME_KEY = "name";
  static const String DB_USER_TABLE_EMAIL_KEY = "email";
  static const String DB_USER_TABLE_PASSWORD_KEY = "password";
  static const String DB_USER_TABLE_PHONE_KEY = "phone";
  static const String DB_USER_TABLE_IMAGE_KEY = "image_path";
  static const String DB_USER_TABLE_GOOGLE_TOKEN_KEY = "google_token";
  static const String DB_USER_TABLE_TOKEN_KEY = "token";
  static const String DB_USER_TABLE_LAST_LIGIN_KEY = "last_login";

  // Cart Table Columns Keys
  static const String DB_CART_TABLE_ID_KEY = "id";
  static const String DB_CART_TABLE_PRODUCT_ID_KEY = "product_id";
  static const String DB_CART_TABLE_QUANTITY_KEY = "quantity";
  static const String DB_CART_TABLE_IS_CHECKED_KEY = "is_checked";
  static const String DB_CART_TABLE_USERS_KEY = "users";

  static Future<void> saveUser(UserModel user) async{
    final doc =await DbHelper().getDb.collection(DbHelper.DB_USER_TABLE_NAME).doc();
    user.uid = doc.id;
    return await doc.set(user.toJson());
  }

  static Future<UserModel?> isUserExist(String token) async {
    var querySnapshot = await DbHelper()
        .getDb
        .collection(DbHelper.DB_USER_TABLE_NAME)
        .where(DB_USER_TABLE_TOKEN_KEY, isEqualTo: token)
        .limit(1)
        .get(); // Use get() instead of snapshots()

    if (querySnapshot.docs.isNotEmpty) {
      var user = UserModel.fromJson(querySnapshot.docs.first.data());
      print('User ID: ${user.uid}'); // Assuming UserModel has an id field
      print('User Data: ${user.name}');
      return user;
    } else {
      print('User No user found.');
      return null;
    }
  }
}
