// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ToDoCart extends StatefulWidget {
  const ToDoCart({
    Key? key,
    required this.title,
    required this.iconData,
    required this.iconColor,
    required this.time,
    required this.check,
    required this.iconBgColor,
  }) : super(key: key);

  final String title;
  final IconData iconData;
  final Color iconColor;
  final String time;
  final bool check;
  final Color iconBgColor;

  @override
  State<ToDoCart> createState() => _ToDoCartState();
}

class _ToDoCartState extends State<ToDoCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
            data: ThemeData(
              primarySwatch: Colors.blue,
              unselectedWidgetColor: Color(0xff5e616a),
            ),
            child: Transform.scale(
              scale: 1.5,
              child: InkWell(
                onTap: () {
                  setState(() {
                    !widget.check;
                  });
                },
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  activeColor: Color(0xff6cf8a9),
                  checkColor: Color(0xff0e3e26),
                  value: widget.check,
                  onChanged: (bool? value) {},
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 75,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Color(0xff2a2e3d),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 33,
                      width: 36,
                      decoration: BoxDecoration(
                        color: widget.iconBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        widget.iconData,
                        color: widget.iconColor,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    Text(
                      widget.time,
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
