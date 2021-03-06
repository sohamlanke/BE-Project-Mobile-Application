// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:manthanapp/Screens/adminpage.dart';
import 'package:manthanapp/Screens/bottomAppbar.dart';
import 'package:manthanapp/Screens/signup.dart';
import 'package:manthanapp/custom_Widgets/MyWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manthanapp/globalConstants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  void initState() {
    initFirebase();
  }

  initFirebase() async {
    await Firebase.initializeApp();
  }

  gotonextScreen() {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => BottomAppBarScreen()));
  }

  checkLoginFirebase({required email, required pass}) async {
    print(email);
    bool flag = false;
    print('Check login called');
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .snapshots()
        .listen((data) {
      print('doc =  ${data.docs[0]['email']} ${data.docs[0]['password']}');
      if (data.docs[0]['password'] == pass) {
        flag = true;
        userid = data.docs[0]['userid'];
        username = data.docs[0]['name'];
        gotonextScreen();
      }
    });
    if (flag == false) {
      _scaffoldkey.currentState!.showSnackBar(SnackBar(
        content: Text('User not found'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
    }
  }

  login() {
    if (email.text == 'admin' && pass.text == 'admin') {
      // gotonextScreen();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Adminpage()) );
    } else {
      // Navigator.of(context).pop();
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => BottomAppBarScreen()));
      try {
        checkLoginFirebase(email: email.text, pass: pass.text);
      } finally {
        print('some error occured!');
        // _scaffoldkey.currentState!.showSnackBar(SnackBar(
        //   content: Text('User not found'),
        //   duration: Duration(seconds: 2),
        //   backgroundColor: Colors.red,
        // ));
      }

      // _scaffoldkey.currentState!.showSnackBar(SnackBar(content: Text('Lol'), duration: Duration(seconds: 1) ,backgroundColor: Colors.red, ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldkey,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    padding: EdgeInsets.only(bottom: 25),
                    child: Image.asset('assets/images/login.png')),
                Text(
                  'Welcome! Login to get started',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                MyInputField(context, label: 'Email', controller: email),
                SizedBox(
                  height: 15,
                ),
                MyInputField(context, label: 'Password', controller: pass)
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: MediaQuery.of(context).size.width - 55,
                margin: EdgeInsets.only(bottom: 125),
                color: Color.fromRGBO(104, 179, 203, 1),
                child: TextButton(
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: () {
                    login();
                  },
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 95),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignupScreen()));
                },
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "Don't have and account? "),
                      TextSpan(
                          text: 'Signup', style: TextStyle(color: Colors.blue)),
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
