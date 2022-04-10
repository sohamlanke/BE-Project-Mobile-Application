// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:manthanapp/custom_Widgets/MyWidgets.dart';

import '../globalConstants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to $title\nLets get you going!',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                height: MediaQuery.of(context).size.height - 330,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MyInputField(context, label: 'Full Name'),
                      SizedBox(
                        height: 15,
                      ),
                      MyInputField(context, label: 'Email id'),
                      SizedBox(
                        height: 15,
                      ),
                      MyInputField(context, label: 'City'),
                      SizedBox(
                        height: 15,
                      ),
                      MyInputField(context, label: 'Contact No'),
                      SizedBox(
                        height: 15,
                      ),
                      MyInputField(context, label: 'Password'),
                      SizedBox(
                        height: 15,
                      ),
                      MyInputField(context, label: 'Confirm Password'),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: MediaQuery.of(context).size.width - 55,
                margin: EdgeInsets.only(bottom: 125),
                color: Color.fromRGBO(104, 179, 203, 1),
                child: TextButton(
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => SignupScreen()));
                  },
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 95),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "Already have and account? "),
                      TextSpan(
                          text: 'Login', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
