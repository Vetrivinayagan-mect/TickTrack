import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticktrack/data/firestore_data.dart';
import 'package:ticktrack/screen/home.dart';
//import 'package:ticktrack/data/firestor.dart';

abstract class AuthenticationDataSource {
  Future<void> register(BuildContext context, String email, String password,
      String confirmPassword, VoidCallback show);
  Future<void> login(
      BuildContext context, String email, String password, VoidCallback show);
}

class AuthenticationRemote extends AuthenticationDataSource {
  @override
  Future<void> register(BuildContext context, String email, String password,
      String confirmPassword, VoidCallback show) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) {
        Firestore_DataSource().CreateUser(email);
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home_Screen(show)));
    } on FirebaseAuthException catch (e) {
      String errorMessage = "SignUp Failed. Please try again.";
      if (e.code == 'weak-password') {
        errorMessage = "Password Provided is too Weak";
      } else if (e.code == "email-already-in-use") {
        errorMessage = "Account Already exists";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(errorMessage,
              style: TextStyle(fontSize: 16, color: Colors.black)),
        ),
      );
    }
  }

  @override
  Future<void> login(BuildContext context, String email, String password,
      VoidCallback show) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home_Screen(show)));
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login failed. Please try again.";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Wrong password provided.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(errorMessage,
              style: TextStyle(fontSize: 16, color: Colors.black)),
        ),
      );
    }
  }
}
