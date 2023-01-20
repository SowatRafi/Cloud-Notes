import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:my_notes/constants/routes.dart';
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
                final userCredential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  await showErrorDialog(context, "Weak Password!");
                } else if (e.code == 'email-already-in-use') {
                  await showErrorDialog(context, "Email already in use!");
                } else if (e.code == 'invalid-email') {
                  await showErrorDialog(
                      context, "I persive, your email is invalid!");
                } else {
                  await showErrorDialog(context, 'Error: ${e.code}');
                }
              } catch (e) {
                await showErrorDialog(context, e.toString());
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
