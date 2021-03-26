import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _enterMessage = "";

  _sendMessage() async {
    FocusScope.of(context).unfocus();
    final userId = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enterMessage,
      'createdAt': DateTime.now(),
      'username': userData['username'],
      'user_image': userData['image_url'],
      'userId': userId.uid,
    });
    _controller.clear();
    setState(() {
      _enterMessage = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            autocorrect: true,
            style: TextStyle(color: Colors.white),
            enableSuggestions: true,
            textCapitalization: TextCapitalization.sentences,
            controller: _controller,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColor)),
              hintText: 'Send a message......',
              hintStyle: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onChanged: (value) => setState(() => _enterMessage = value),
          )),
          IconButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Colors.white,
            icon: Icon(Icons.send),
            onPressed: _enterMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
