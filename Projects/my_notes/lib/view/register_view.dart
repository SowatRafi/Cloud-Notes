import 'package:flutter/material.dart';

import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/services/auth/auth_exception.dart';
import 'package:my_notes/services/auth/auth_service.dart';
import 'package:my_notes/utilities/show_erro_dialog.dart';
import '/code_repeat.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
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
                // create user
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                // send email verification
                AuthService.firebase().sendEmailVerification();
                // navigating to verify email view page
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordAuthException {
                await showErrorDialog(
                  context,
                  'Your password is weak!',
                );
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(
                  context,
                  'You email is already in our database',
                );
              } on InvalidEmailAuthException {
                await showErrorDialog(
                  context,
                  "Sorry! Your email seems invalid to me! Please check your email address.",
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  "Failed to register!",
                );
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already registered? Login here!'),
          )
        ],
      ),
    );
  }
}
