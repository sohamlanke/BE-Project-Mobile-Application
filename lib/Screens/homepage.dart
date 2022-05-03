// ignore_for_file: prefer_const_constructors, duplicate_ignore, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manthanapp/globalConstants.dart';

Widget homepage(context) {
  final topBar = new AppBar(
    backgroundColor: new Color(0xfff8faf8),
    centerTitle: true,
    elevation: 1.0,
    leading: new Icon(Icons.camera_alt),
    title: SizedBox(
        height: 35.0, child: Image.asset("assets/images/insta_logo.png")),
    // ignore: prefer_const_literals_to_create_immutables
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Icon(Icons.send),
      )
    ],
  );

  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blueAccent[100],
      title: Text('SAVage social media app'),
    ), //can use topbar
    body: new InstaBody(),
  );
}

class InstaBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // Expanded(flex: 1, child: new InstaStories()),
        Expanded(child: InstaList())
      ],
    );
  }
}

class InstaList extends StatefulWidget {
  @override
  _InstaListState createState() => _InstaListState();
}

class _InstaListState extends State<InstaList> {
  bool isPressed = false;
  String url =
      "https://i.pinimg.com/736x/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg";

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    // return ListView.builder(
    //   itemCount: 5,
    //   itemBuilder: (context, index) => ContentUI()
    //   // index == 0
    //   //     ? new SizedBox(
    //   //         // child: new InstaStories(),
    //   //         height: deviceSize.height * 0.15,
    //   //       )
    //   //     :

    // );
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tweets').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              // return Container(
              //   child: Center(child: Text(document['content'])),
              // );
              return ContentUI(
                  content: document['content'],
                  imageurl: document['image_url']);
            }).toList(),
          );
        });
  }

  Widget ContentUI({required content, required imageurl}) {
    print("image url = $imageurl");
    // imageurl =
    //     "https://images.hindustantimes.com/auto/img/2021/12/30/600x338/2019-Mustang-2_1587188510753_1640852384911.jpg";
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  new Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill, image: new NetworkImage(url)),
                    ),
                  ),
                  new SizedBox(
                    width: 10.0,
                  ),
                  new Text(
                    "SAVage user",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              new IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: null,
              )
            ],
          ),
        ),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('$content'),
        )),
        Flexible(
          fit: FlexFit.loose,
          child: new Image.network(
            // "https://images.hindustantimes.com/auto/img/2021/12/30/600x338/2019-Mustang-2_1587188510753_1640852384911.jpg",
            "$imageurl",
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(
                        isPressed ? Icons.favorite : FontAwesomeIcons.heart),
                    color: isPressed ? Colors.red : Colors.black,
                    onPressed: () {
                      setState(() {
                        isPressed = !isPressed;
                      });
                    },
                  ),
                  new SizedBox(
                    width: 16.0,
                  ),
                  new Icon(
                    FontAwesomeIcons.comment,
                  ),
                  new SizedBox(
                    width: 16.0,
                  ),
                  new Icon(FontAwesomeIcons.paperPlane),
                ],
              ),
              new Icon(FontAwesomeIcons.bookmark)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Liked by sohamlanke,saloni,vaishnavi and 528,331 others",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: <Widget>[
        //       new Container(
        //         height: 40.0,
        //         width: 40.0,
        //         decoration: new BoxDecoration(
        //           shape: BoxShape.circle,
        //           image: new DecorationImage(
        //               fit: BoxFit.fill, image: new NetworkImage(url)),
        //         ),
        //       ),
        //       new SizedBox(
        //         width: 10.0,
        //       ),
        //       Expanded(
        //         child: new TextField(
        //           decoration: new InputDecoration(
        //             border: InputBorder.none,
        //             hintText: "Add a comment...",
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        SizedBox(height: 8,),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //   child: Text("1 Day Ago", style: TextStyle(color: Colors.grey)),
        // )
      ],
    );
  }
}
