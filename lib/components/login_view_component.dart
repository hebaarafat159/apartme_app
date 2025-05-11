import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class LoginViewComponent extends StatefulWidget {
  final VoidCallback onSuccess;
  final Function(String) onFailure;

  const LoginViewComponent(
      {super.key, required this.onSuccess, required this.onFailure});

  @override
  State<LoginViewComponent> createState() => _LoginViewComponentState();
}

class _LoginViewComponentState extends State<LoginViewComponent> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          shrinkWrap: true,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: const InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.email),
                labelText: 'Email',
              ),
              validator: (value) => (value == null || value.isEmpty)
                  ? 'Please Enter Your Email Address'
                  : null,
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.lock),
                labelText: 'Password',
              ),
              validator: (value) => (value == null || value.isEmpty)
                  ? 'Please Enter Your Password'
                  : null,
            ),
            const SizedBox(height: 16.0),
            // login button
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity, // Makes button full-width
              child:
              ElevatedButton(
                onPressed: _authenticate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'OR',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
            // google sign in button
            SizedBox(
              width: double.infinity, // Makes button full-width
              child: ElevatedButton.icon(
                onPressed: _signInWithGoogle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                icon: const Icon(
                  Icons.g_mobiledata,
                  color: Colors.white,
                  size: 30,
                ),
                label: const Text(
                  "SignIn With Google",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _authenticate() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please Wait ...');
      final email = _emailController.text;
      final password = _passwordController.text;
      try {
        await Provider.of<UserProvider>(context, listen: false)
            .loginUser(email, password);
        EasyLoading.dismiss();
        widget.onSuccess();
      } on FirebaseAuthException catch (error) {
        EasyLoading.dismiss();
        widget.onFailure(error.message!);
      }
    }
  }

  void _signInWithGoogle() async {
    try {
      await Provider.of<UserProvider>(context, listen: false).loginWithGoogle();
      EasyLoading.dismiss();
      widget.onSuccess();
    } on FirebaseAuthException catch (error) {
      EasyLoading.dismiss();
      widget.onFailure(error.message!);
    }
  }
}
