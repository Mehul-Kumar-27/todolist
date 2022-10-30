// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:todolist/pages/login_page.dart';
import 'package:todolist/services/databaseuser.dart';
import 'package:velocity_x/velocity_x.dart';

import '../pages/home_page.dart';

class LoginInWithEmailPassword {
  String email;
  String password;
  LoginInWithEmailPassword({
    required this.email,
    required this.password,
  });

  final auth = FirebaseAuth.instance;

  loginWithEmailPassword() {
    try {
      auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      showSimpleNotification("Invalid username or password".text.make());
    }
  }
}

class SignUpWithEmailAndPassword {
  String email;
  String password;
  String username;
  String phonenumber;
  SignUpWithEmailAndPassword({
    required this.email,
    required this.password,
    required this.username,
    required this.phonenumber,
  });

  DatabaseMethods databaseMethods = DatabaseMethods();

  signUpWithEmailAndPassword() {
    try {
      Map<String, dynamic> userInMap = {
        "username": username,
        "email": email,
        "phonenumber": phonenumber
      };

      databaseMethods.updoadUserInfo(userInMap);
    } catch (e) {}
  }
}

// class AuthenticationServices {

//    final FirebaseAuth auth = FirebaseAuth.instance;
//    final storge = FlutterSecureStorage();
//   static Future<void> signInWithGoogle() async {
//     DatabaseMethods databaseMethods = DatabaseMethods();
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       GoogleSignIn _googleSignIn = GoogleSignIn();

//       bool isSignedIn = await _googleSignIn.isSignedIn();

//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;
//       print("waiting for authentication !!!!!!!!!!!!!!!!!!!1");
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );

//       print("waiting for authentication !!!!!!!!!!!!!!!!!!!1");
//       await FirebaseAuth.instance.signInWithCredential(credential);

//       User? user = auth.currentUser;

//       String? username = user!.displayName;

//       databaseMethods.getUserByUsername(username).then((val) {
//         return;
//       });

//       print("Creating user");

//       Map<String, dynamic> userMap = {
//         "name": user!.displayName,
//         "email": user.email,
//         "phonenumber": user.phoneNumber
//       };

//       databaseMethods.updoadUserInfo(userMap);
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
// }
class AuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  final storage = new FlutterSecureStorage();
  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      storeTokenAndData(userCredential);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const HomePage()),
          (route) => false);
    } catch (e) {
      print("here---->");
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> signOut({BuildContext? context}) async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      await storage.delete(key: "token");
      
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context!).showSnackBar(snackBar);
    }
  }

  void storeTokenAndData(UserCredential userCredential) async {
    print("storing token and data");
    await storage.write(
        key: "token", value: userCredential.credential!.token.toString());
    await storage.write(
        key: "usercredential", value: userCredential.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }
}
