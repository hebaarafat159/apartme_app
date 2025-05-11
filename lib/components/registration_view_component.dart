import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class RegistrationViewComponent extends StatefulWidget {
  final VoidCallback onSuccess;
  final Function(String) onFailure;

  const RegistrationViewComponent(
      {super.key, required this.onSuccess, required this.onFailure});

  @override
  State<RegistrationViewComponent> createState() =>
      _RegistrationViewComponentState();
}

class _RegistrationViewComponentState extends State<RegistrationViewComponent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
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
            _buildTextField(
              controller: _nameController,
              label: "Full Name",
              icon: Icons.person,
              keyboardType: TextInputType.text,
              validator: (value) => (value == null || value.isEmpty)
                  ? 'Please Enter Your Name'
                  : null,
            ),
            const SizedBox(height: 8.0),
            _buildTextField(
              controller: _phoneController,
              label: "Phone Number",
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              validator: (value) => (value == null || value.isEmpty)
                  ? 'Please Enter Your Mobile Number'
                  : null,
            ),
            const SizedBox(height: 8.0),
            _buildTextField(
              controller: _emailController,
              label: "Email",
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => (value == null || value.isEmpty)
                  ? 'Please Enter Your Email Address'
                  : null,
            ),
            const SizedBox(height: 8.0),
            _buildTextField(
              controller: _passwordController,
              label: "Password",
              icon: Icons.lock,
              keyboardType: TextInputType.text,
              obscureText: true,
              validator: (value) => (value == null || value.isEmpty)
                  ? 'Please Enter Your Password'
                  : null,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                child: const Text(
                  "Register",
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

  /// Helper method to reduce redundancy in TextFormField creation
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required TextInputType keyboardType,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: Icon(icon),
        labelText: label,
      ),
      validator: validator,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please Wait ...');
      final name = _nameController.text;
      final phone = _phoneController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      try {
        await Provider.of<UserProvider>(context, listen: false)
            .registerUser(name, phone, email, password);
        EasyLoading.dismiss();
        widget.onSuccess();
      } on FirebaseAuthException catch (error) {
        EasyLoading.dismiss();
        widget.onFailure(error.message!);
      }
    }
  }
}
