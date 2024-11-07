import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/src/constants/asset_paths.dart';
import 'package:flash_chat/src/screens/login_screen.dart';
import 'package:flash_chat/src/widgets/action_button.dart';
import 'package:flash_chat/src/widgets/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({
    super.key,
  });

  static const route = 'signup';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  late String _nickname;
  late String _email;
  late String _password;
  late bool _registering;

  @override
  void initState() {
    super.initState();
    _nickname = '';
    _email = '';
    _password = '';
    _registering = false;
  }

  void createUser(BuildContext context) async {
    setState(() {
      _registering = true;
    });
    try {
      final newUserCred = await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      if (newUserCred.user != null) {
        String? newUserEmail = newUserCred.user?.email;
        if (newUserEmail != null) {
          String name = _nickname.isEmpty ? 'Anonymous' : _nickname;
          db.collection('users').doc(newUserEmail).set({'name': name});
        }
        await _auth.signOut();
        if (context.mounted) {
          Navigator.popAndPushNamed(context, LoginScreen.route);
        }
      } else {
        debugPrint('new user credential is null');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        if (context.mounted) {
          Navigator.popAndPushNamed(context, LoginScreen.route);
        }
        if (context.mounted) {
          Navigator.popAndPushNamed(context, LoginScreen.route);
        }
      } else {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() {
      _registering = false;
    });
  } //createUser()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ModalProgressHUD(
        inAsyncCall: _registering,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    kLogoAssetPath,
                    height: 200,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              InputTextField(
                onChanged: (name) => _nickname = name,
                hintText: 'Enter your name',
                labelText: 'Name',
              ),
              InputTextField(
                onChanged: (newEmail) => _email = newEmail,
                hintText: 'Enter your email',
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              InputTextField(
                onChanged: (newPassword) => _password = newPassword,
                hintText: 'Enter your password',
                labelText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 12.0),
              ActionButton(
                text: 'Register',
                buttonTheme: ButtonColorTheme.dark,
                onPressed: () => createUser(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
