import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:hydrogen_complian/pages/register_page.dart';

import '../pages/login_page.dart';

class ShowAlertDialog {
  showMyDialog(BuildContext context,
      {required String message, required IconData icon, required String text}) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.blueAccent,
      title: const Center(
          child: Text(
        'Message',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginPage();
              }));
            },
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () async {
              await FlutterClipboard.copy(text);
            },
            icon: const Icon(
              Icons.copy_outlined,
              color: Colors.white,
            ))
      ],
    );
    showDialog(
        context: context,
        builder: ((context) {
          return alertDialog;
        }));
  }
}
