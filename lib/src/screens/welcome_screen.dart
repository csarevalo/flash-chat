import 'package:flash_chat/src/constants/asset_paths.dart';
import 'package:flash_chat/src/screens/login_screen.dart';
import 'package:flash_chat/src/screens/registration_screen.dart';
import 'package:flash_chat/src/widgets/action_button.dart';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
  });

  static const route = 'welcome';

  @override
  Widget build(BuildContext context) {
    const double heightBetween = 16.0;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const WelcomeScreenTitle(),
            const SizedBox(height: heightBetween * 1.25),
            ActionButton(
              text: 'Log In',
              buttonTheme: ButtonColorTheme.light,
              onPressed: () => Navigator.pushNamed(
                context,
                LoginScreen.route,
              ),
            ),
            const SizedBox(height: heightBetween),
            ActionButton(
              text: 'Register',
              buttonTheme: ButtonColorTheme.dark,
              onPressed: () => Navigator.pushNamed(
                context,
                RegistrationScreen.route,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreenTitle extends StatelessWidget {
  const WelcomeScreenTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Hero(
          tag: 'logo',
          child: Image.asset(
            kLogoAssetPath,
            height: 50,
          ),
        ),
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Flash Chat',
              textAlign: TextAlign.center,
              textStyle: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
              speed: kRadialReactionDuration,
            ),
          ],
        )
        // const Text(
        //   'Flash Chat ',
        //   style: TextStyle(
        //     fontSize: 48,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
      ],
    );
  }
}
