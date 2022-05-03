import 'package:flutter/material.dart';
import 'package:manthanapp/Screens/homepage.dart';

class Adminpage extends StatefulWidget {
  const Adminpage({Key? key}) : super(key: key);

  @override
  State<Adminpage> createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Admin page')),
      body: homepage(context, isadmin: true ),
    );
  }
}
