import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class AddToDoPage extends StatefulWidget {
  const AddToDoPage({super.key});

  @override
  State<AddToDoPage> createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _description = TextEditingController();
  String type = "";
  String category = "";

  late DateTime _selectedDate;
  String dateText = "";
  late String time;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black87),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      CupertinoIcons.arrow_left_circle,
                      color: Colors.blue[300],
                      size: 28,
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Create"
                          .text
                          .textStyle(GoogleFonts.poppins(
                              fontSize: 30,
                              color: Colors.blue[500],
                              fontWeight: FontWeight.bold))
                          .make(),
                      const SizedBox(
                        height: 8,
                      ),
                      "New Todo"
                          .text
                          .textStyle(GoogleFonts.poppins(
                              fontSize: 30,
                              color: Colors.blue[500],
                              fontWeight: FontWeight.bold))
                          .make(),
                      const SizedBox(
                        height: 25,
                      ),
                      label("Task Title"),
                      const SizedBox(
                        height: 20,
                      ),
                      title(),
                      const SizedBox(
                        height: 30,
                      ),
                      label("Task Type"),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          taskSelect("Important", 0xff2664fa),
                          const SizedBox(
                            width: 20,
                          ),
                          taskSelect("Planned", 0xff2bc8d9)
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      label("Description"),
                      const SizedBox(
                        height: 12,
                      ),
                      description(),
                      const SizedBox(
                        width: 25,
                      ),
                      label("Category"),
                      const SizedBox(
                        height: 12,
                      ),
                      Wrap(
                        runSpacing: 10,
                        children: [
                          categorySelect("Food", 0xff6d6e),
                          const SizedBox(
                            width: 20,
                          ),
                          categorySelect("Workout", 0xff29732),
                          const SizedBox(
                            width: 20,
                          ),
                          categorySelect("Work", 0xff6557ff),
                          const SizedBox(
                            width: 20,
                          ),
                          categorySelect("Study", 0xff234ebd),
                          const SizedBox(
                            width: 20,
                          ),
                          categorySelect("Run", 0xff2bc8d9),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                _presentDatePicker();
                              },
                              icon: const Icon(Icons.calendar_month,
                                  color: Colors.white)),
                          SizedBox(
                            width: 10,
                          ),
                          "Choose Time"
                              .text
                              .color(Colors.white)
                              .textStyle(TextStyle(fontSize: 15))
                              .make(),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      button(),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
          dateText = DateFormat.yMMMEd().format(pickedDate);
        });
      }
    });
  }

  // _pickedDate() async {
  //   DateTime? dateTime = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(DateTime.now().year - 5),
  //       lastDate: DateTime(DateTime.now().year - 5));

  //   if (dateTime != null) {
  //     setState(() {
  //       pickedDate = dateTime;
  //     });

  //     time = "Date: ${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
  //   }
  // }

  Widget button() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection("Todo").add({
          "Category": category,
          "description": _description.text,
          "task": type,
          "title": _titlecontroller.text,
          "dateTime": dateText
        });
        Navigator.pop(context);
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              colors: [Color(0xff8a32f1), Color(0xffad32f9)]),
        ),
        child: const Center(
            child: Text(
          "Add Task",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 155,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 56, 47, 47),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _description,
        maxLines: null,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Description",
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 17),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    ).py12();
  }

  Widget taskSelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          type = label;
        });
      },
      child: Chip(
        backgroundColor: type == label ? Colors.green : Color(color),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          category = label;
        });
      },
      child: Chip(
        backgroundColor: category == label ? Colors.green : Color(color),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 56, 47, 47),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _titlecontroller,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 17),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(label,
        style: const TextStyle(
          color: Colors.white60,
          fontWeight: FontWeight.w600,
          fontSize: 16.5,
          letterSpacing: 0.2,
        ));
  }
}
