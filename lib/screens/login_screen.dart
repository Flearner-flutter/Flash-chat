import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../rounded_button.dart';
import '../rounded_text_field.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  late String email;
  late String password;

  void showLoadingIndicator(bool isShow) {
    setState(() {
      _isLoading = isShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: _isLoading,
        opacity: 0.5,
        progressIndicator: const CircularProgressIndicator(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: "logo",
                child: SizedBox(
                  child: Image.asset('images/logo.png'),
                  height: 200.0,
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              RoundedTextField(
                hintText: 'Enter your email.',
                enabledBorderColor: Colors.lightBlueAccent,
                focusedBorderColor: Colors.lightBlueAccent,
                onChanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              RoundedTextField(
                hintText: 'Enter your password.',
                enabledBorderColor: Colors.lightBlueAccent,
                focusedBorderColor: Colors.lightBlueAccent,
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                buttonName: "Log In",
                buttonColor: Colors.lightBlueAccent,
                onPressed: () async {
                  showLoadingIndicator(true);
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    Navigator.pushNamed(context, ChatScreen.id);
                  } catch (e) {
                    print(e);
                  }
                  showLoadingIndicator(false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
