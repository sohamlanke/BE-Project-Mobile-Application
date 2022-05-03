// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:manthanapp/Screens/bottomAppbar.dart';
import 'package:manthanapp/custom_Widgets/MyWidgets.dart';

import '../globalConstants.dart';
import 'dart:math';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController city = new TextEditingController();
  TextEditingController contact = new TextEditingController();
  TextEditingController password = new TextEditingController();

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  void addtoFirestore(
      {required city,
      required email,
      required name,
      required contact,
      required password}) {
    userid =
        generateRandomString(32); //this variable is store in global.constants
    username = name;  // this variable is store in global.constants
    FirebaseFirestore.instance.collection('users').add({
      'city': '$city',
      'email': '$email',
      'name': '$name',
      'contact': '$contact',
      'password': '$password',
      'userid': '$userid'
    });
    print('Firestore test function triggered!');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BottomAppBarScreen()));
  }

  void initState() {
    initFirebase();
  }

  initFirebase() async {
    await Firebase.initializeApp();
  }

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
                      MyInputField(context,
                          label: 'Full Name', controller: name),
                      SizedBox(
                        height: 15,
                      ),
                      MyInputField(context,
                          label: 'Email id', controller: email),
                      SizedBox(
                        height: 15,
                      ),
                      MyInputField(context, label: 'City', controller: city),
                      SizedBox(
                        height: 15,
                      ),
                      MyInputField(context,
                          label: 'Contact No', controller: contact),
                      SizedBox(
                        height: 15,
                      ),
                      MyInputField(context,
                          label: 'Password', controller: password),
                      SizedBox(
                        height: 15,
                      ),
                      // MyInputField(context, label: 'Confirm Password'),
                      // SizedBox(
                      //   height: 15,
                      // ),
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
                    print(name.text);
                    print(email.text);
                    print(city.text);
                    print(contact.text);
                    print(password.text);
                    addtoFirestore(
                        city: city.text,
                        email: email.text,
                        name: name.text,
                        contact: contact.text,
                        password: password.text);
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
