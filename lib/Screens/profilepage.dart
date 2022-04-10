// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget ProfilePage() {
  return Scaffold(
    body: Column(
      children: [
    SizedBox(height: 100),
    Row(
      children: [
        SizedBox(
          width: 20,
        ),
        CircleAvatar(
          radius: 50,
        ),
        SizedBox(
          width: 30,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.blue,
              width: 200,
              height: 35,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'John Doe',
                  style: TextStyle(color: Colors.white , fontSize: 16),
                ),
              ),
            ),
            Text('Welcome! sjdvnjksdnn knkksand ksd', ),
          ],
        ),
      ],
    ),
    SizedBox(height: 10,),
    Container( width: 330, height: 50, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)), ),
    SizedBox(height: 10,),
    Container(width: 20000, height: 2, color: Colors.blue,),
    Padding(
      padding: EdgeInsets.only(left: 10, top: 3),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text('POSTS', style: TextStyle(fontSize: 14), )),
    ),
    Container(width: 20000, height: 2, color: Colors.blue,),
      ],
    ),
  );
}
