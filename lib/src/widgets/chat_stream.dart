import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/src/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class ChatStream extends StatelessWidget {
  const ChatStream({
    super.key,
    required this.db,
    required this.user,
  });

  final FirebaseFirestore db;
  final User user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: db.collection('global_chat').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        List<Widget> msgWidgets = [];
        final globalChatMsgs = snapshot.data!.docs;
        globalChatMsgs.sort((a, b) => b['sentOn'].compareTo(a['sentOn']));
        for (var msg in globalChatMsgs) {
          String sender = msg['sender'];
          String textMsg = msg['text'];
          Timestamp dtSent = msg['sentOn'];
          msgWidgets.add(
            MessageBubble(
              sender: sender,
              textMsg: textMsg,
              dtSent: dtSent,
              userInfo: user,
            ),
          );
        }
        return Expanded(
          child: ListView.builder(
            reverse: true,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 20.0,
            ),
            itemCount: msgWidgets.length,
            itemBuilder: (context, index) => msgWidgets[index],
          ),
        );
      },
    );
  }
}
