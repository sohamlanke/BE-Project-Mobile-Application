// ignore_for_file: non_constant_identifier_names, file_names, prefer_const_constructors

import 'package:flutter/material.dart';

Widget MyInputField(BuildContext context,{required String label}) {
  return Container(
      // width: MediaQuery.of(context).size.width - 100,
      margin: EdgeInsets.symmetric(horizontal: 45),
      child: TextFormField(
          decoration: InputDecoration(
        labelText: label,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
      )));
}
