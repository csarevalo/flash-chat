import 'package:flash_chat/src/screens/chat_room_screen.dart';
import 'package:flash_chat/src/screens/login_screen.dart';
import 'package:flash_chat/src/screens/registration_screen.dart';
import 'package:flash_chat/src/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) {
        switch (settings.name) {
          case WelcomeScreen.route:
            return const WelcomeScreen();
          case LoginScreen.route:
            return const LoginScreen();
          case RegistrationScreen.route:
            return const RegistrationScreen();
          case ChatRoomScreen.route:
            return const ChatRoomScreen();
          default:
            return const Scaffold(
              body: Center(
                child: Text('404: Missing Route'),
              ),
            );
        }
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 1);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: kThemeAnimationDuration, // 300 milliseconds
      reverseTransitionDuration: kThemeAnimationDuration, // 300 milliseconds
    );
  }
}
