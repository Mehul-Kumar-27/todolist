import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  updoadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("userData").add(userMap);
  }

  getUserByUsername(String? username) async {
    return await FirebaseFirestore.instance
        .collection("userData")
        .where("name", isEqualTo: username)
        .get();
  }
}
