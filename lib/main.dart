import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/src/flash_chat_app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const FlashChatApp());

  // Sign out after closing app
  await FirebaseAuth.instance.signOut();

  // whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
}
