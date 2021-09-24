// ignore_for_file: file_names, camel_case_types, prefer_const_constructors


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manthanapp/Screens/loginScreen.dart';

import '../globalConstants.dart';

class getStarted extends StatefulWidget {
  const getStarted({Key? key}) : super(key: key);

  @override
  _getStartedState createState() => _getStartedState();
}

class _getStartedState extends State<getStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                padding: EdgeInsets.only(bottom: 25),
                child: Image.network(
                    'https://m.media-amazon.com/images/M/MV5BNTg3NGY4NDEtOTRmNy00MTExLTk2OTEtMGUwMjFjNTNlMjM5XkEyXkFqcGdeQXRyYW5zY29kZS13b3JrZmxvdw@@._V1_.jpg')),
            // ignore: prefer_const_constructors
            Text(
              'Engage and entertain through $title',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width-55,
                margin: EdgeInsets.only(bottom: 125),
                color: Color.fromRGBO(104, 179, 203, 1),
                  child: TextButton(
                child: Text('Get Started', style: TextStyle(fontSize: 18 ,color: Colors.white),),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              )),
            )

        ],
      ),
    );
  }
}
