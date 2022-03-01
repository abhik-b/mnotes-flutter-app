import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/views/login_view.dart';
import 'package:notes/views/register_view.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      '/login/': (context) => const LoginView(),
      '/register/': (context) => const RegisterView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            // TODO: Handle this case.
            return const CircularProgressIndicator(
              strokeWidth: 2,
            );
          case ConnectionState.waiting:
            // TODO: Handle this case.
            return const CircularProgressIndicator(
              strokeWidth: 2,
            );
          case ConnectionState.active:
            return const CircularProgressIndicator(
              strokeWidth: 2,
            );
          case ConnectionState.done:
            // final auth = FirebaseAuth.instance.currentUser;
            // print(auth);
            // if (auth?.emailVerified ?? false) {
            //   return const Text('Verified user');
            // } else {
            //   return const VerifyEmail();
            // }
            return const LoginView();
        }
      },
    );
  }
}
