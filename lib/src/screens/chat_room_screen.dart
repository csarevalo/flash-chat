import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/src/screens/login_screen.dart';
import 'package:flash_chat/src/screens/welcome_screen.dart';
import 'package:flash_chat/src/widgets/chat_room_drawer.dart';
import 'package:flash_chat/src/widgets/chat_stream.dart';
import 'package:flash_chat/src/widgets/message_text_box.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});
  static const route = 'chat';

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  late User _loggedInUser;
  late String _name;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void getCurrentUser() async {
    User? user = _auth.currentUser;
    if (user == null) {
      Navigator.popAndPushNamed(context, WelcomeScreen.route);
      return;
    }
    _loggedInUser = user;
    if (_loggedInUser.email == null) {
      _name = 'Anonymous';
      return;
    }
    _name = 'Loading name';
    _db.collection('users').doc(_loggedInUser.email).get().then(
      (docSnapshot) {
        if (docSnapshot.exists) {
          final userData = docSnapshot.data() ?? {};
          if (userData.isNotEmpty) {
            setState(() {
              _name = userData['name'];
            });
          }
        }
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }

  void signOutUser(BuildContext context) async {
    await _auth.signOut();
    if (context.mounted) {
      Navigator.popAndPushNamed(context, LoginScreen.route);
    }
  }

  void sendMessage() {
    if (_textController.text.isNotEmpty) {
      var message = {
        'sender': _loggedInUser.email ?? '',
        'text': _textController.text,
        'sentOn': Timestamp.now(),
      };
      _db.collection('global_chat').add(message).then(
        (docSnapshot) {
          debugPrint("Added Data with ID: ${docSnapshot.id}");
          _textController.clear();
        },
        onError: (e) => debugPrint("Error sending message: $e"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ChatRoomDrawer(
        user: _name,
        onPressedSignOut: () {},
      ),
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Open Drawer',
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(kLogoAssetPath, height: 30),
            Icon(Icons.bubble_chart_rounded),
            Text(' Chat Room '),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => signOutUser(context),
            tooltip: 'Log Out',
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ChatStream(
              db: _db,
              user: _loggedInUser,
            ),
            MessageTextBox(
              controller: _textController,
              onEditingComplete: sendMessage,
              onSend: sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
