import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();
        final docs = snapShot.data.docs;
        final userId = FirebaseAuth.instance.currentUser.uid;
        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            docs[index]['username'],
            docs[index]['text'],
            docs[index]['user_image'],
            docs[index]['userId'] == userId,
            key: ValueKey(docs[index]['userId']),
          ),
        );
      },
    );
  }
}
