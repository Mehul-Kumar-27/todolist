import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:todolist/pages/AddToDoPage.dart';
import 'package:todolist/pages/login_page.dart';

import 'pages/home_page.dart';
import 'services/authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(OverlaySupport(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthClass authClass = AuthClass();

  Widget currentPage = LoginPage();

  @override
  void initState() {
    super.initState();
    authClass.signOut();
    checkLogin();
  }

  checkLogin() async {
    String? tokne = await authClass.getToken();
    print("tokne");
    if (tokne != null)
      setState(() {
        currentPage = HomePage();
        //currentPage = LoginPage();
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
