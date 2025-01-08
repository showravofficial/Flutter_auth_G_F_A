import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../models/user_model.dart';
import 'login_view.dart';


class HomeScreen extends StatelessWidget {
  final UserModel user;
  final AuthController _authController = AuthController();

  HomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _authController.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.cyan,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (user.photoURL != null)
                CircleAvatar(
                  backgroundImage: NetworkImage(user.photoURL!),
                  radius: 50,
                ),
              SizedBox(height: 20),
              ListTile(
                title: Text("Name: ${user.displayName ?? "No Name"}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                subtitle: Text("Email: ${user.email ?? "No Email"}",style: TextStyle(fontSize: 18,color: Colors.black),),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text("Sign-In Successful",style: TextStyle(fontSize: 18),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
