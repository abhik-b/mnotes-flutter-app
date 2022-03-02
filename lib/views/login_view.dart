import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter your Email'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: _password,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your password'),
              )),
          ElevatedButton(
            child: const Text('Login'),
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                email: email,
                password: password,
              )
                  .then((value) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/notes/', (route) => false);
              }).catchError((error) {});
            },
          ),
          const Text('Or'),
          TextButton(
            child: const Text('Register'),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/register/', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
