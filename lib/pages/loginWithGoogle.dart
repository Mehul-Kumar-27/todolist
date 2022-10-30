import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({super.key});

  @override
  State<LoginWithGoogle> createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  late String _username;
  late String _phonenumber;
  late String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 80,
          ),
          Row(
            children: [
              "Login with Google"
                  .text
                  .textStyle(GoogleFonts.poppins(
                    fontSize: 25,
                    color: Colors.blue[500],
                  ))
                  .semiBold
                  .make()
                  .px12(),
              const Image(
                height: (35),
                width: (25),
                image: AssetImage('assets/images/google.png'),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          "Let's complete your profile before you login with Google."
              .text
              .textStyle(
                  GoogleFonts.poppins(fontSize: 19, color: Colors.grey[600]))
              .make()
              .px12(),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Username",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: (17),
              color: Colors.grey[600],
            ),
          ).px12(),
          const SizedBox(
            height: (10.41),
          ),
          SizedBox(
            height: (50),
            child: TextField(
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintStyle: GoogleFonts.poppins(
                  color: Colors.grey[500],
                ),
                hintText: 'What should we call you ?',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular((6.94)),
                  ),
                ),
              ),
              onChanged: ((value) {
                setState(() {
                  _username = value;
                });
              }),
            ),
          ).px12(),
          const SizedBox(
            height: (10.41),
          ),
          Text(
            "Phone Number",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: (15),
              color: Colors.grey[600],
            ),
          ).px12(),
          const SizedBox(
            height: (10.41),
          ),
          SizedBox(
            height: (50),
            child: TextField(
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintStyle: GoogleFonts.poppins(
                  color: Colors.grey[500],
                ),
                hintText: '**********',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular((6.94)),
                  ),
                ),
              ),
              onChanged: (value) {
                _phonenumber = value.trim();
              },
            ),
          ).px12(),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 40,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color.fromARGB(255, 219, 219, 219),
                  width: 1.2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular((28)),
                ),
              ),
              // need to add google sign in
              onPressed: () async {
                
              },
              child: Container(
                padding: const EdgeInsets.only(
                  left: (13.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      height: (30),
                      width: (20),
                      image: AssetImage('assets/images/google.png'),
                    ),
                    const SizedBox(
                      width: (12),
                    ),
                    Text(
                      "Login with Google",
                      style: GoogleFonts.poppins(
                        color: Colors.blue[500],
                        fontSize: (17),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).px12(),
        ],
      ),
    );
  }
}
