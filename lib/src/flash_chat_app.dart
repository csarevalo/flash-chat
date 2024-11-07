import 'package:flash_chat/src/screens/welcome_screen.dart';
import 'package:flash_chat/src/utils/custom_router.dart';
import 'package:flutter/material.dart';

class FlashChatApp extends StatelessWidget {
  const FlashChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash Chat',
      themeMode: ThemeMode.dark,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.tealAccent,
          surface: Colors.teal[400],
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.tealAccent,
          surface: Colors.teal[700],
          brightness: Brightness.dark,
        ),
      ),
      onGenerateRoute: CustomRouter.generateRoute,
      initialRoute: WelcomeScreen.route,
      // routes: {
      //   WelcomeScreen.route: (ctx) => const WelcomeScreen(),
      //   LoginScreen.route: (ctx) => const LoginScreen(),
      //   RegistrationScreen.route: (ctx) => const RegistrationScreen(),
      //   ChatScreen.route: (ctx)=> const ChatScreen.route(),
      // },
      debugShowCheckedModeBanner: false,
    );
  }
}
