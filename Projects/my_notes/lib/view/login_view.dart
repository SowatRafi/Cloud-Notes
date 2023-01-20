import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/code_repeat.dart';

import 'package:my_notes/constants/routes.dart';

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
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(notesRoute, (route) => false);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  await showErrorDialog(context, "User not found!");
                } else if (e.code == 'wrong-password') {
                  await showErrorDialog(context, "Wrong credentials!");
                } else {
                  await showErrorDialog(context, 'Error: ${e.code}');
                }
              } catch (e) {
                await showErrorDialog(context, e.toString());
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

Future<void> showErrorDialog(BuildContext context, String text) {
  return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: const Text("An error occured"),
          content: Text(text),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Okay!"))
          ],
        );
      }));
}
