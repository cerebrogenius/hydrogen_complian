import 'package:flutter/material.dart';

class Utils {
  showSnackBar(BuildContext context, {required String message}) {
    SnackBar snackBar = SnackBar(
      duration: const Duration(seconds: 30),
      content: SizedBox(
        height: 30,
        child: Center(child: Text(message))),
      backgroundColor: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
    return snackBar;
  }
}
