import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {

  MessageBubble(this.username, this.message,this.userImage, this.isMe, {this.key});
  final String username;
  final String message;
  final String userImage;
  final bool isMe;
  final Key key;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: isMe? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                  bottomLeft: isMe ? Radius.circular(0): Radius.circular(14),
                  bottomRight: isMe ? Radius.circular(0): Radius.circular(14),
                ),
              ),
              width: 140,
              margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe? Colors.black: Theme.of(context).accentTextTheme.headline6.color
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe? Colors.black: Theme.of(context).accentTextTheme.headline6.color,
                    ),
                    textAlign: isMe? TextAlign.end: TextAlign.start,
                  ),
                ],
              ),
            ),

          ],
        ),
        Positioned(
          top: 0,
          left: !isMe? 120: null,
          right: isMe? 120: null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
    );
  }
}
