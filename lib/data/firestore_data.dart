import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../model/notes_model.dart';

class Firestore_DataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> CreateUser(String email) async {
    try {
      await _firestore
          .collection('user')
          .doc(_auth.currentUser!.uid)
          .set({"id": _auth.currentUser!.uid, "email": email});
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<bool> addNote(String subtitle, String title, int image) async {
    var uuid = Uuid().v4();
    DateTime data = new DateTime.now();
    try {
      await _firestore
          .collection('user')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .set({
        'id': uuid,
        'title': title,
        'subtitle': subtitle,
        'isDone': false,
        'image': image,
        'time': '${data.hour}:${data.minute}',
      });
      return true;
    } catch (e) {}
    return true;
  }

  Future<bool> Update_Note(
      String uuid, String title, String subtitle, int image) async {
    try {
      DateTime data = new DateTime.now();
      await _firestore
          .collection('user')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({
        'time': '${data.hour}:${data.minute}',
        'subtitle': subtitle,
        'title': title,
        'image': image,
      });
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<bool> Delete_Note(String uuid) async {
    try {
      await _firestore
          .collection('user')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .delete();
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<bool> is_Done(String uuid, bool is_Don) async {
    try {
      await _firestore
          .collection('user')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({
        'isDone': is_Don,
      });
      return true;
    } catch (e) {
      return true;
    }
  }

  Stream<QuerySnapshot> stream(bool isDone) {
    return _firestore
        .collection('user')
        .doc(_auth.currentUser!.uid)
        .collection('notes')
        .where('isDone', isEqualTo: isDone)
        .snapshots();
  }

  List<Note> get_Notes(AsyncSnapshot<QuerySnapshot> snapshot) {
    try {
      return snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>; // Ensure it's a Map
        return Note(
          doc.id,
          data['subtitle'],
          data['time'],
          data['image'],
          data['title'],
          data['isDone'],
        );
      }).toList();
    } catch (e) {
      print("Error fetching notes: $e");
      return [];
    }
  }
}
