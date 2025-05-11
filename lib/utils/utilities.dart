import 'package:flutter/material.dart';

class Utilities {
  static void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Future<void> pickImageFromDevice(ImageSource source, Function onPickImage) async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: source);
  //
  //   if (pickedFile != null) {
  //     setState(() {
  //           onPickImage(pickedFile);
  //
  //     });
  //   }
  // }
}
