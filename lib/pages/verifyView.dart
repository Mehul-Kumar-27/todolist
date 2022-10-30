import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todolist/pages/home_page.dart';
import 'package:velocity_x/velocity_x.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final auth = FirebaseAuth.instance;
  late User user;

  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      checkEmailVerification();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Image.asset(
          "assets/images/mail_box.png",
          fit: BoxFit.cover,
        ),
        Expanded(
            child: VxArc(
          height: 30,
          arcType: VxArcType.CONVEX,
          edge: VxEdge.TOP,
          child: Container(
            color: Colors.grey[300],
            child: Column(children: [
              const SizedBox(
                height: 70,
              ),
              "We have sent a verification link to the ${user.email} , please verify to continue."
                  .text
                  .color(Colors.lightBlue)
                  .size(20)
                  .make()
                  .px20(),
            ]),
          ),
        ))
      ],
    ));
  }

  Future<void> checkEmailVerification() async {
    user = auth.currentUser!;

    await user.reload();

    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }
}
