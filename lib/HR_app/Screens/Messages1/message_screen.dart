import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_admin/HR_app/Screens/Messages1/components/body.dart';
import 'package:hr_admin/HR_app/Screens/Messages1/components/model.dart';
import 'package:hr_admin/HR_app/constants.dart';

// class MyChat{
//   MyChat({this.title, this.message, this.id});
//   String title;
//   String message;
//   int id;

// }

class MessagesScreen extends StatefulWidget with ChangeNotifier {
  static ValueNotifier<int> length = ValueNotifier(myMsg.length);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final Stream<QuerySnapshot> groupchat =
      FirebaseFirestore.instance.collection('Chat').snapshots();

  String userID;
  // Future<void> delete(id) {
  //   return pets
  //       .doc(id)
  //       .delete()
  //       .catchError((onError) => print("Failed to delete user: $onError"));
  // }
  getuserid() async {
    await getdata('userID').then((value) => userID = value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    User user = _auth.currentUser;
    userID = user.uid;
    // getuserid();
    print(userID);
    print('00000000000000000000000000000000000000');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: StreamBuilder(
        stream: groupchat,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('waiting');
            return const Center(child: CircularProgressIndicator());
          }
          print('done::::::::::::::::${snapshot.data}');
          final List mychat = [];
          snapshot.data.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            a['id'] = document.id;
            // var parse = json.encode(a);
            // var mystudent = studentFromJson(parse);
            mychat.add(a);
          }).toList();
          return Body(
            model: mychat,
            userID: userID,
          );
        },
      ),
      // body: ValueListenableBuilder(
      //   valueListenable: MessagesScreen.length,
      //   builder: (context, value, _) {
      //     return Body();
      //   },
      // ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/user_2.png'),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Stack Designers',
                style: TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
              ),
              Text(
                '7 Online, form 12 people',
                style: TextStyle(fontSize: 12),
              ),
            ],
          )
        ],
      ),
      actions: [
        IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        SizedBox(width: 10)
      ],
    );
  }
}
