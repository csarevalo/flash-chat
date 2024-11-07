import 'package:flash_chat/src/constants/asset_paths.dart';
import 'package:flash_chat/src/screens/chat_room_screen.dart';
import 'package:flash_chat/src/widgets/action_button.dart';
import 'package:flash_chat/src/widgets/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  static const route = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String _email;
  late String _password;
  late bool _logginIn;

  @override
  void initState() {
    super.initState();
    _email = '';
    _password = '';
    _logginIn = false;
  }

  void loginUser(BuildContext context) async {
    setState(() {
      _logginIn = true;
    });
    try {
      final userCred = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      if (userCred.user != null) {
        if (context.mounted) {
          Navigator.popAndPushNamed(context, ChatRoomScreen.route);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      } else {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() {
      _logginIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: _logginIn,
        child: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      kLogoAssetPath,
                      height: 150,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                InputTextField(
                  onChanged: (newEmail) => _email = newEmail,
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                InputTextField(
                  onChanged: (newPassword) => _password = newPassword,
                  onEditingComplete: () {
                    if (_email.isEmpty) return;
                    if (_password.isEmpty) return;
                    loginUser(context);
                  },
                  obscureText: true,
                  hintText: 'Enter your password',
                  labelText: 'Password',
                ),
                const SizedBox(height: 12.0),
                ActionButton(
                  text: 'Log In',
                  buttonTheme: ButtonColorTheme.light,
                  onPressed: () => loginUser(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
