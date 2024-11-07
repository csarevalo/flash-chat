import 'package:flutter/material.dart';

class ChatRoomDrawer extends StatelessWidget {
  final String user;
  final void Function()? onPressedSignOut;

  const ChatRoomDrawer({
    super.key,
    required this.user,
    this.onPressedSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Center(
              child: Text(
                user,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: onPressedSignOut,
              child: const Text(
                'Sign Out',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
