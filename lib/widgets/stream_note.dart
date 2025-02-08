import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticktrack/widgets/task_widget.dart';

import '../data/firestore_data.dart';

class Stream_note extends StatefulWidget {
  bool done;
  Stream_note(this.done, {super.key});

  @override
  State<Stream_note> createState() => _Stream_noteState();
}

class _Stream_noteState extends State<Stream_note> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore_DataSource().stream(widget.done),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final notelist = Firestore_DataSource().get_Notes(snapshot);
          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: notelist.length,
              itemBuilder: (context, index) {
                final note = notelist[index];
                return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      Firestore_DataSource().Delete_Note(note.id);
                    },
                    child: Task_Widget(note));
              });
        });
  }
}
