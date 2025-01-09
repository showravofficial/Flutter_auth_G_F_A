import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_auth/views/home_view.dart';
import '../controllers/apple_auth_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/facebook_auth_controller.dart';


class LoginScreen extends StatelessWidget {
  final AuthController _authController = AuthController();
  final FacebookAuthController _facebookAuthController = FacebookAuthController();
  final AppleAuthController _appleAuthController = AppleAuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text("Login")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              width: 220,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final user = await _authController.signInWithGoogle();
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
                    );
                  }
                },
               icon: FaIcon(FontAwesomeIcons.google),
                label: Text("Sign in with Google",style: TextStyle(color: Colors.black)),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 40,
              width: 220,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final user = await _facebookAuthController.signInWithFacebook();
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
                    );
                  }
                },
                icon: FaIcon(FontAwesomeIcons.facebook),
                label: Text("Sign in with Facebook",style: TextStyle(color: Colors.black)),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 40,
              width: 220,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final user = await _appleAuthController.signInWithApple();
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
                    );
                  }
                },

                icon: FaIcon(FontAwesomeIcons.apple,size: 25,),
                label: Text("Sign in with Apple",style: TextStyle(color: Colors.black),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
