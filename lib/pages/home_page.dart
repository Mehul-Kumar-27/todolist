import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todolist/pages/AddToDoPage.dart';
import 'package:todolist/pages/ToDoCart.dart';
import 'package:todolist/pages/login_page.dart';
import 'package:todolist/pages/view_data.dart';
import 'package:todolist/services/authentication.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text(
            "Today's Schedule",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ).py20(),
          actions: [
            IconButton(
                onPressed: () {
                  authClass.signOut().then((value) =>
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false));
                },
                icon: const Icon(Icons.logout_outlined)),
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/avatar.png"),
            ),
            SizedBox(
              width: 25,
            )
          ],
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(35),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  DateTime.now().toString(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              )),
        ),
        bottomNavigationBar:
            BottomNavigationBar(backgroundColor: Colors.black87, items: [
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 32,
                color: Colors.white,
              ),
              label: ""),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddToDoPage()));
              },
              child: Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Colors.indigoAccent, Colors.purple])),
                child: const Icon(
                  Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
            label: "",
          ),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 32,
                color: Colors.white,
              ),
              label: ""),
        ]),
        body: StreamBuilder(
            stream: _stream,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> document = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;

                    IconData iconData;
                    Color iconcolor;

                    switch (document["Category"]) {
                      case "Food":
                        iconData = Icons.local_grocery_store;
                        iconcolor = Colors.blue;

                        break;
                      case "Workout":
                        iconData = Icons.alarm;
                        iconcolor = Colors.red;

                        break;

                      case "Work":
                        iconData = Icons.work_history_outlined;
                        iconcolor = Colors.green;

                        break;

                      case "Study":
                        iconData = Icons.school;
                        iconcolor = Colors.purple;

                        break;

                      default:
                        iconData = Icons.run_circle_outlined;
                        iconcolor = Colors.deepPurpleAccent;
                    }
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => ViewData(
                                    document: document,
                                    id: snapshot.data!.docs[index].id)));
                      },
                      child: ToDoCart(
                        title: document["title"] == null
                            ? "Hey There"
                            : document["title"],
                        check: false,
                        iconBgColor: Colors.white,
                        iconColor: iconcolor,
                        iconData: iconData,
                        time: document["dateTime"],
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
