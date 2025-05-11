import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/login_view_component.dart';
import '../components/registration_view_component.dart';
import '../utils/utilities.dart';
import 'home_page.dart';

enum AuthChoice { login, register }

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthChoice _authChoice = AuthChoice.login;
  final _formKey = GlobalKey<FormState>();
  final String _errMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            shrinkWrap: true,
            children: [
              Text(
                "Welcome",
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SegmentedButton<AuthChoice>(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) =>
                      states.contains(MaterialState.selected)
                          ? Colors.blueAccent
                          : null),
                  foregroundColor: MaterialStateProperty.resolveWith((states) =>
                      states.contains(MaterialState.selected)
                          ? Colors.white
                          : null),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0))),
                ),
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment<AuthChoice>(
                      value: AuthChoice.login, label: Text('LOGIN')),
                  ButtonSegment<AuthChoice>(
                      value: AuthChoice.register, label: Text('REGISTER')),
                ],
                selected: {_authChoice},
                onSelectionChanged: (choice) {
                  setState(() => _authChoice = choice.first);
                },
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedCrossFade(
                    firstChild: LoginViewComponent(
                      onSuccess: () {
                        Utilities.showErrorMessage(
                            context, "User Has Logged in Successfully.....");
                        context.go(HomePage.routeName);
                      },
                      onFailure: (value) =>
                          Utilities.showErrorMessage(context, value),
                    ),
                    secondChild: RegistrationViewComponent(
                      onSuccess: () {
                        Utilities.showErrorMessage(
                            context, "User Has Registered Successfully.....");
                        context.go(HomePage.routeName);
                      },
                      onFailure: (value) =>
                          Utilities.showErrorMessage(context, value),
                    ),
                    crossFadeState: _authChoice == AuthChoice.login
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 500),
                  ),
                ),
              ),
              if (_errMsg.isNotEmpty)
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Error",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.0, color: Colors.red),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
