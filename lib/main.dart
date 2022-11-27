import 'package:flutter/material.dart';
import 'package:hydrogen_complian/pages/login_page.dart';
import 'package:hydrogen_complian/pages/main_page.dart';
import 'package:hydrogen_complian/providers/complain_provider.dart';
import 'package:provider/provider.dart';

import 'providers/paste_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PasteProvider()),
        ChangeNotifierProvider(create: (_) => ComplainProvider())
      ],
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Hydrogen complain",
          home: Scaffold(body: LoginPage()),
        );
      },
    );
  }
}
