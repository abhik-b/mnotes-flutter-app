import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/constants/routes.dart';

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
                try {
                  await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  )
                      .then((value) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(notesRoute, (route) => false);
                  });
                } on FirebaseAuthException catch (e) {
                  switch (e.code) {
                    case 'wrong-password':
                      showSnackBar(context, 'Wrong Password');
                      break;
                    case 'invalid-email':
                      showSnackBar(context, 'Invalid email');
                      break;
                    case 'user-not-found':
                      showSnackBar(context, 'User Not Found');
                      break;
                    default:
                      showSnackBar(context, 'Something went wrong !!!');
                  }
                }
              }),
          const Text('Or'),
          TextButton(
            child: const Text('Register'),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: Colors.red,
  ));
}
