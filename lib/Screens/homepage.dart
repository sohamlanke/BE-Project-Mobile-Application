import 'package:flutter/material.dart';

Widget homepage(context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Feeds"),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          // ignore: prefer_const_constructors
          icon: Icon(
            Icons.filter_list,
          ),
          onPressed: () {},
        ),
      ],
    ),
    body: ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        // Map post = posts[index];
        return Text('Post here');
      },
    ),
    floatingActionButton: FloatingActionButton(
      // ignore: prefer_const_constructors
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {},
    ),
  );
}