import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // tables names
  static const String DB_ADMIN_TABLE_NAME = "admins";
  static const String DB_USER_TABLE_NAME = "users";


  // name object keys
  static const String DB_NAME_CODE_KEY = "code";
  static const String DB_NAME_VALUE_KEY = "value";

  // return firebase database instance object
  FirebaseFirestore get getDb => _db;

  void isFirestoreConnection() async {
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection(DB_USER_TABLE_NAME).get();
      print('Firestore Connection Successful');
    } catch (e) {
      print('Firestore Connection Failed: $e');
    }
  }
}
