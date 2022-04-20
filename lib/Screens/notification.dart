import 'package:flutter/material.dart';

Widget notificationPage() {
  return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) =>
              notification('   some notification ${index + 1}')));
}

Widget notification(Title) {
  return Container(
    height: 60,
    child:
        Card(child: Align(alignment: Alignment.centerLeft, child: Text(Title))),
  );
}
