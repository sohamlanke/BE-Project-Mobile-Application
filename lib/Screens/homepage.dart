// ignore_for_file: prefer_const_constructors, duplicate_ignore, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manthanapp/globalConstants.dart';

Widget homepage(context, {isadmin = false}) {
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
      title: Text(isadmin == true ? 'Admin Page' : 'SAVage social media app'),
    ), //can use topbar
    body: new InstaBody(
      isadmin: isadmin,
    ),
  );
}

class InstaBody extends StatelessWidget {
  final isadmin;

  const InstaBody({Key? key, this.isadmin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // Expanded(flex: 1, child: new InstaStories()),
        Expanded(
            child: InstaList(
          isadmin: isadmin,
        ))
      ],
    );
  }
}

class InstaList extends StatefulWidget {
  final isadmin;

  const InstaList({Key? key, this.isadmin}) : super(key: key);
  @override
  _InstaListState createState() => _InstaListState(isadmin);
}

class _InstaListState extends State<InstaList> {
  final isadmin;
  bool isPressed = false;
  String url =
      "https://i.pinimg.com/736x/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg";

  _InstaListState(this.isadmin);

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
        stream: FirebaseFirestore.instance.collection(isadmin?'tweets':'original').snapshots(),
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
              return  isadmin == true ? ContentUI(
                isadmin: isadmin, label: document['label'],
                content: document['content'], imageurl: document['image_url'], documentid: document.id) : ContentUI(
                isadmin: isadmin,
                content: document['content'],
                imageurl: document['image_url'],
                documentid: document.id,
              );
            }).toList(),
          );
        });
  }

  Widget ContentUI(
      {required content,
      required imageurl,
      required documentid,
      label,
      isadmin = false}) {
    print("image url = $imageurl");
    print('isadmin = $isadmin');
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
          child: GestureDetector(
            onLongPress: () {
            print('Long presssed');
            showAlertbox(documentid);
          },
            child: new Image.network(
              // "https://images.hindustantimes.com/auto/img/2021/12/30/600x338/2019-Mustang-2_1587188510753_1640852384911.jpg",
              "$imageurl",
              fit: BoxFit.cover,
            ),
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
        isadmin == false? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Liked by sohamlanke,saloni,vaishnavi and 528,331 others",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ): Container(),
        isadmin == true
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Label : $label",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            : Container(),
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
        SizedBox(
          height: 8,
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //   child: Text("1 Day Ago", style: TextStyle(color: Colors.grey)),
        // )
      ],
    );
  }

  Future<void> DeleteImage(String jobId) {
    return FirebaseFirestore.instance.collection('tweets').doc(jobId).delete();
  }

  showAlertbox(documentid) async {
    print('in alert box');
    bool result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Do you want to delete?'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pop(false); // dismisses only the dialog and returns false
              },
              child: Text('No'),
            ),
            FlatButton(
              onPressed: () {
                DeleteImage(documentid);
                Navigator.of(context, rootNavigator: true)
                    .pop(true); // dismisses only the dialog and returns true
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
