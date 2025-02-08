import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // If using Firebase
import 'package:flutter/rendering.dart';
import 'package:ticktrack/const/colors.dart';
import 'package:ticktrack/screen/login.dart';
import 'package:ticktrack/widgets/stream_note.dart';

import 'add_screen.dart';

class Home_Screen extends StatefulWidget {
  final VoidCallback show;
  const Home_Screen(this.show, {super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

bool event = true;

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                "images/profile.jpg",
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Hi, Vetri Vinayagan",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              size: 24,
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LogIn_Screen(widget.show)),
              );
            },
          )
        ],
      ),
      body: SafeArea(
          child: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            setState(() {
              event = true;
            });
          } else if (notification.direction == ScrollDirection.reverse) {
            setState(() {
              event = false;
            });
          }
          return true;
        },
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Stream_note(false),
                  Center(
                    child: Text(
                      "isDone",
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade500),
                    ),
                  ),
                  Stream_note(true),
                ],
              ),
            ),
          ],
        ),
      )),
      floatingActionButton: Visibility(
        visible: event,
        child: FloatingActionButton(
            backgroundColor: custom_green,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Add_Screen()));
            }),
      ),
    );
  }
}
