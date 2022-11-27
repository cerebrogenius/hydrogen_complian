// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hydrogen_complian/models/user_model.dart';
import 'package:hydrogen_complian/providers/paste_provider.dart';
import 'package:hydrogen_complian/repo/http_repo.dart';
import 'package:hydrogen_complian/utils/alert_dialog.dart';
import 'package:hydrogen_complian/utils/snackbar.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_botton.dart';
import '../widgets/text_field_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("LET YOUR VOICES BE HEARD",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
            const SizedBox(
              height: 25,
            ),
            MyTextField(
              controller: nameController,
              extendTextFiled: false,
              labelText: "enter username",
              obscureText: false,
            ),
            const SizedBox(
              height: 25,
            ),
            MyTextField(
                controller: emailController,
                extendTextFiled: false,
                labelText: "enter Email",
                obscureText: false),
            const SizedBox(
              height: 25,
            ),
            CustomButton(
                isLoading: isLoading,
                onTap: () async {
                  setState(() {
                    isLoading = !isLoading;
                  });
                  UserModel user = UserModel(
                      email: emailController.text.trim(),
                      name: nameController.text.trim());
                  GeneralHttpRequest request = GeneralHttpRequest();
                  var output = await request.registerUser(
                      api: '/Register/', object: user);

                  if (output == null) {
                    // ignore: use_build_context_synchronously
                    return ScaffoldMessenger.of(context).showSnackBar(Utils()
                        .showSnackBar(context, message: output.toString()));
                  } else if (double.tryParse(output.toString()) != null) {
                    ScaffoldMessenger.of(context).showSnackBar(Utils()
                        .showSnackBar(context, message: output.toString()));
                  } else {
                    UserModel userCreated = UserModel.fromJson(output);
                    ShowAlertDialog().showMyDialog(context,
                        message:
                            'Registration Successful, password is ${userCreated.secretCode}',
                        icon: Icons.check,
                        text: userCreated.secretCode.toString());
                  }
                  setState(() {
                    isLoading = !isLoading;
                  });
                  Provider.of<PasteProvider>(context,listen:false).paste = true;
                  // Navigator.pop(context);
                },
                text: "Register",
                icon: Icons.login_rounded,
                color: Colors.blueAccent),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Already Have An Account? "),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.blueAccent),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
