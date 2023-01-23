import 'package:flutter/material.dart';
import 'package:my_notes/code_repeat.dart';

import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/services/auth/auth_exception.dart';
import 'package:my_notes/services/auth/auth_service.dart';
import 'package:my_notes/utilities/show_erro_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Column(
        children: [
          // email
          TextField(
            controller: _email,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: CodeRepeat().hintText('xxxxx@xxxxx.xxx'),
          ),
          // password
          TextField(
            controller: _password,
            obscureText: true,
            autocorrect: false,
            enableInteractiveSelection: false,
            decoration: CodeRepeat().hintText('xxxxxxx'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );

                final user = AuthService.firebase().currentUser;

                if (user?.isEmailVerified ?? false) {
                  // if email verified
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(notesRoute, (route) => false);
                } else {
                  // not verified
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmailRoute, (route) => false);
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(
                  context,
                  'User not found!',
                );
              } on WrongPasswordAuthException {
                await showErrorDialog(
                  context,
                  'Wrong credentials!',
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  'Authentication Error!',
                );
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Not registered yet? Register here!'),
          )
        ],
      ),
    );
  }
}
