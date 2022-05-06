// ignore_for_file: avoid_types_as_parameter_names, avoid_print
// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manthanapp/Screens/addnewpost.dart';
import 'package:manthanapp/Screens/homepage.dart';
import 'package:manthanapp/Screens/notification.dart';
import 'package:manthanapp/Screens/profilepage.dart';
import 'package:manthanapp/Screens/reference/profilepage2.dart';
import 'package:manthanapp/globalConstants.dart';

class BottomAppBarScreen extends StatefulWidget {
  const BottomAppBarScreen({Key? key}) : super(key: key);

  @override
  _BottomAppBarScreenState createState() => _BottomAppBarScreenState();
}

class _BottomAppBarScreenState extends State<BottomAppBarScreen> {
  PageController _myPage = PageController(initialPage: 0);
  int _currentPage = 0;

  bool isrefreshed = false;

  void refresh() {
    if (isrefreshed == false) {
      setState(() {});
      isrefreshed = true;
    }
  }

  void initState() {
    print('initstate called');
    fetchimages();
  }

  List images = [];
  void fetchimages() {
    print("fetch images called");
    FirebaseFirestore.instance
        .collection('tweets')
        .where('userid', isEqualTo: userid)
        .snapshots()
        .listen((data) {
      for (int i = 0; i < data.docs.length; i++) {
        images.add(data.docs[i]['image_url']);
      }
      print(images);
      // Widget mybody = ProfilePage2(context, images);
      // refreshfn();
      // Navigator.of(context).push(
      // MaterialPageRoute(builder: (context) => ProfilePage2(context, images)));
      // print("g");
      // print(mybody);
      // print('gg');
      // refreshfn();
      // print('doc =  ${data.docs[0]['email']} ${data.docs[0]['password']}');
      // if (data.docs[0]['password'] ==  ) {
      //   userid = data.docs[0]['userid'];
      //   username = data.docs[0]['name'];
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 55,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                icon: _currentPage == 0
                    ? Icon(Icons.home)
                    : Icon(Icons.home_outlined),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(0);
                  });
                },
              ),
              // IconButton(
              //   iconSize: 30.0,
              //   padding: EdgeInsets.only(right: 28.0),
              //   icon: _currentPage == 1
              //       ? Icon(Icons.search_off)
              //       : Icon(Icons.search_outlined),
              //   onPressed: () {
              //     setState(() {
              //       _myPage.jumpToPage(1);
              //     });
              //   },
              // ),
              // IconButton(
              //   iconSize: 30.0,
              //   padding: EdgeInsets.only(left: 28.0),
              //   icon: _currentPage == 2
              //       ? Icon(Icons.notifications)
              //       : Icon(Icons.notifications_none_outlined),
              //   onPressed: () {
              //     setState(() {
              //       _myPage.jumpToPage(2);
              //     });
              //   },
              // ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: _currentPage == 3
                    ? Icon(Icons.person)
                    : Icon(Icons.person_outline),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(3);
                  });
                },
              )
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _myPage,
        onPageChanged: (int) {
          print('Page Changes to index $int');
          setState(() {
            _currentPage = int;
          });
        },
        children: <Widget>[
          Center(
            child: Container(
              child: homepage(context),
            ),
          ),
          Center(
            child: Container(
              child: Text('Empty Body 1'),
            ),
          ),
          Center(
            child: Container(
              child: notificationPage(),
            ),
          ),
          Center(
            child: Container(
              child: ProfilePage2(context, images),
            ),
          )
        ],
        physics:
            NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
      ),
      floatingActionButton: Container(
        height: 60.0,
        width: 60.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddPost()));
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            // elevation: 5.0,
          ),
        ),
      ),
    );
  }
}
