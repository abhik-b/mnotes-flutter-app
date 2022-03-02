import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

enum MenuAction { home, settings, logout }

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          PopupMenuButton(
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.home:
                    devtools.log('home');
                    break;
                  case MenuAction.settings:
                    devtools.log('settings');
                    break;
                  case MenuAction.logout:
                    final shouldLogout = await showLogoutDialog(context);
                    if (shouldLogout) {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacementNamed('/login/');
                    }

                    break;
                }
              },
              itemBuilder: (context) => [
                    const PopupMenuItem<MenuAction>(
                      value: MenuAction.home,
                      child: Text('Home'),
                    ),
                    const PopupMenuItem<MenuAction>(
                      value: MenuAction.settings,
                      child: Text('Settings'),
                    ),
                    const PopupMenuItem<MenuAction>(
                      value: MenuAction.logout,
                      child: Text('Logout'),
                    ),
                  ])
        ],
      ),
    );
  }
}

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      }).then((value) => value ?? false);
}
