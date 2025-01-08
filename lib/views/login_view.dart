import 'package:flutter/material.dart';
import 'package:project_auth/views/home_view.dart';
import '../controllers/auth_controller.dart';


class LoginScreen extends StatelessWidget {
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text("Login")),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.cyan,
        ),
        child: Center(
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
            icon: Icon(Icons.login),
            label: Text("Sign in with Google"),
          ),
        ),
      ),
    );
  }
}
