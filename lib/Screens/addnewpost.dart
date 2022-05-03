// ignore_for_file: unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../globalConstants.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  void addPosttoFirestore({required content, imageurl = 'none' }) {
    FirebaseFirestore.instance.collection('newtweets').add({
      'content': '$content',
      'date': '${DateTime.now()}',
      'userid': '$userid',
      'imageurl' : '$imageurl'
    });
    print('Firestore test function triggered!');
    Navigator.of(context).pop();
    // Navigator.push(context, MaterialPageRoute(builder: (context) => BottomAppBarScreen() ) );
  }

  TextEditingController content = new TextEditingController();
  TextEditingController imageurl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print('Adding ${content.text} to firestore');
          addPosttoFirestore(content: content.text, imageurl: imageurl.text );
        },
        label: Text('Add Post'),
        backgroundColor: Colors.blue,
      ),
      appBar: AppBar(
        title: Text('Add new Post'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 19, right: 8, bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(children: [
                textHeadingContainer("Add something new"),
                Text('', style: TextStyle(color: Colors.red))
              ]),
              SizedBox(height: 10),
              Container(
                height: 300,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blueGrey[100]),
                child: TextFormField(
                  readOnly: false,
                  maxLines: null,
                  controller: content,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.multiline,
                  // decoration: inputDecoration(hint),
                ),
              ),
              SizedBox(height: 25,),
              textHeadingContainer("Add image url"),
              Container(
                // height: 300,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blueGrey[100]),
                child: TextFormField(
                  readOnly: false,
                  maxLines: null,
                  controller: imageurl ,
                  cursorColor: Colors.black,
                  // keyboardType: TextInputType.multiline,
                  // decoration: inputDecoration(hint),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textHeadingContainer(String text) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
  );
}
