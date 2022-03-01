import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Column(children: [
        const Text('Please verify your email address'),
        TextButton(
            onPressed: () async {
              final auth = FirebaseAuth.instance.currentUser;
              await auth?.sendEmailVerification();
            },
            child: const Text('Send verification email')),
      ]),
    );
  }
}
