import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticktrack/auth/auth_page.dart';

import '../screen/home.dart';

class Main_Page extends StatefulWidget {
  final VoidCallback show;
  const Main_Page(this.show, {super.key});

  @override
  State<Main_Page> createState() => _Main_PageState();
}

class _Main_PageState extends State<Main_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Home_Screen(widget.show);
            } else {
              return Auth_Page();
            }
          }),
    );
  }
}
