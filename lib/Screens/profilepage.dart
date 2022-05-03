// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manthanapp/globalConstants.dart';

Widget ProfilePage(context, refreshfn) {
  List images = [];
  Widget mybody = Center(child: CircularProgressIndicator());
  void fetchimages() {
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
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProfilePage2(context, images)));
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

  fetchimages();
  return Scaffold(
    body: mybody,
  );
}

class ProfilePage3 extends StatefulWidget {
  const ProfilePage3({Key? key, this.images}) : super(key: key);
  final images;
  @override
  State<ProfilePage3> createState() => _ProfilePage3State(this.images);
}

class _ProfilePage3State extends State<ProfilePage3> {
  final images;

  _ProfilePage3State(this.images);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfilePage2(context, images),
    );
  }
}

Widget ProfilePage2(context, images) {
  Random random = Random();

  // List images = [];

  // bool isloading = true;
  bool isrefreshed = false;

  // void fetchimages() {
  //   FirebaseFirestore.instance
  //       .collection('tweets')
  //       .where('userid', isEqualTo: userid)
  //       .snapshots()
  //       .listen((data) {
  //     for (int i = 0; i < data.docs.length; i++) {
  //       images.add(data.docs[i]['image_url']);
  //     }
  //     print(images);
  //     isloading = false;
  //     if (isrefreshed == false) {
  //       // refreshfn();
  //       isrefreshed = true;
  //     }
  //     // print('doc =  ${data.docs[0]['email']} ${data.docs[0]['password']}');
  //     // if (data.docs[0]['password'] ==  ) {
  //     //   userid = data.docs[0]['userid'];
  //     //   username = data.docs[0]['name'];
  //     // }
  //   });
  // }

  // fetchimages();

  return Scaffold(
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 60),
            CircleAvatar(
              // backgroundImage: AssetImage(
              //   "assets/images/cm${random.nextInt(10)}.jpeg",
              // ),
              backgroundImage: NetworkImage(
                  "https://i.pinimg.com/736x/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg"),
              radius: 50,
            ),
            SizedBox(height: 10),
            Text(
              '$username',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 3),
            Text(
              "BE Project",
              style: TextStyle(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlatButton(
                  child: Icon(
                    Icons.message,
                    color: Colors.white,
                  ),
                  color: Colors.grey,
                  onPressed: () {},
                ),
                SizedBox(width: 10),
                FlatButton(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildCategory("Posts"),
                  _buildCategory("Friends"),
                  _buildCategory("Groups"),
                ],
              ),
            ),
            SizedBox(height: 20),
            // isloading == true
            //     ? Center(
            //         child: CircularProgressIndicator(),
            //       )
            //     :
                 GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    padding: EdgeInsets.all(5),
                    itemCount: images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 200 / 200,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Image.network(
                          // "assets/images/cm${random.nextInt(10)}.jpeg",
                          // "https://i.pinimg.com/736x/82/4c/75/824c75d5d8baddac1e3ab99a48b77f36.jpg",
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildCategory(String title) {
  Random random = Random();
  return Column(
    children: <Widget>[
      Text(
        random.nextInt(10000).toString(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      SizedBox(height: 4),
      Text(
        title,
        style: TextStyle(),
      ),
    ],
  );
}
