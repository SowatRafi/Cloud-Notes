import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_notes/view/login_view.dart';
import '/firebase_options.dart';
import 'code_repeat.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginView(),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // `late` Although this field do not have any value, this field will assigned with value before it is used.
  late final TextEditingController _email;
  late final TextEditingController _password;

  // Initial State - One time
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  // Dispose State
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
        title: const Text("Register"),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
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
                      final userCredential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email, password: password);
                      print(userCredential);
                    },
                    child: const Text("Register"),
                  ),
                ],
              );
            default:
              return const Text("Loading...");
          }
        },
      ),
    );
  }
}
