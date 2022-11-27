import 'package:flutter/material.dart';
import 'package:hydrogen_complian/pages/main_page.dart';
import 'package:hydrogen_complian/pages/register_page.dart';
import 'package:hydrogen_complian/providers/paste_provider.dart';

import 'package:hydrogen_complian/repo/http_repo.dart';
import 'package:hydrogen_complian/widgets/custom_botton.dart';
import 'package:hydrogen_complian/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("LET YOUR VOICE BE HEARD",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
            const SizedBox(
              height: 25,
            ),
            MyTextField(
              controller: nameController,
              hintText: "name you registered with",
              labelText: "enter username",
              obscureText: false,
              extendTextFiled: false,
            ),
            const SizedBox(
              height: 25,
            ),
            MyTextField(
                paste: Provider.of<PasteProvider>(context).paste,
                controller: passwordController,
                extendTextFiled: false,
                hintText: "your password is your secret code",
                labelText: "enter password",
                obscureText: true),
            const SizedBox(
              height: 25,
            ),
            CustomButton(
                isLoading: isLoading,
                onTap: () async {
                  setState(() {
                    isLoading = !isLoading;
                  });
                  print(isLoading);
                  var accessToken = await GeneralHttpRequest().loginUser(
                      name: nameController.text.trim(),
                      secretCode: passwordController.text.toString().trim(),
                      api: '/login/');
                  print(accessToken.toString());
                  final pref = await SharedPreferences.getInstance();
                  await pref.setString('token', accessToken['access_token']);
                  //  = accessToken['access_token'];
                  setState(() {
                    isLoading = !isLoading;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const MainPage();
                    }),
                  );
                },
                text: "Login",
                icon: Icons.login_rounded,
                color: Colors.blueAccent),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Here For The First Time? "),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const RegisterPage();
                      }));
                    },
                    child: const Text(
                      "Register",
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
