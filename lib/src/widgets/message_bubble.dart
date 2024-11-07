import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.userInfo,
    required this.sender,
    required this.textMsg,
    required this.dtSent,
  });

  final User userInfo;
  final String sender;
  final String textMsg;
  final Timestamp dtSent;

  @override
  Widget build(BuildContext context) {
    final bool isUserMsg = userInfo.email.toString() == sender;
    final DateTime dt = dtSent.toDate();
    final String dtParsed = DateFormat("E, MMM d \"yy, h:mm aaa").format(dt);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isUserMsg ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            dtParsed,
            textAlign: isUserMsg ? TextAlign.end : TextAlign.start,
            style: const TextStyle(fontSize: 8.0),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              isUserMsg ? 'Me' : sender,
              textAlign: isUserMsg ? TextAlign.end : TextAlign.start,
              style: const TextStyle(fontSize: 11.0),
            ),
          ),
          Material(
            elevation: 4.0,
            borderRadius: BorderRadius.only(
              topLeft: isUserMsg ? const Radius.circular(16.0) : Radius.zero,
              topRight: isUserMsg ? Radius.zero : const Radius.circular(16.0),
              bottomLeft: const Radius.circular(16.0),
              bottomRight: const Radius.circular(16.0),
            ),
            color: isUserMsg
                ? Theme.of(context).colorScheme.tertiaryContainer
                : Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 6.0,
              ),
              child: Text(
                textMsg,
                style: TextStyle(
                  color: isUserMsg
                      ? Theme.of(context).colorScheme.onTertiaryContainer
                      : Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 4.0),
          //   child: Text(
          //     dtParsed,
          //     textAlign: isUserMsg ? TextAlign.end : TextAlign.start,
          //     style: const TextStyle(fontSize: 9.0),
          //   ),
          // ),
        ],
      ),
    );
  }
}
