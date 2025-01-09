import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class FacebookAuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> signInWithFacebook() async {
    try {
      // Trigger the Facebook login process
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        // Get the access token string
        final String accessToken = result.accessToken!.tokenString;

        // Use the access token to create a Firebase credential
        final OAuthCredential credential = FacebookAuthProvider.credential(accessToken);

        // Sign in with Firebase using the Facebook credential
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        // Return the user information if sign-in is successful
        if (user != null) {
          return UserModel(
            displayName: user.displayName,
            email: user.email,
            photoURL: user.photoURL,
          );
        }
      } else if (result.status == LoginStatus.cancelled) {
        print("Facebook login cancelled by the user.");
      } else if (result.status == LoginStatus.failed) {
        print("Facebook login failed: ${result.message}");
      }
    } catch (e) {
      print("Error during Facebook Sign-In: $e");
    }
    return null;
  }

  Future<void> signOut() async {
    // Log out from Facebook and Firebase
    await FacebookAuth.instance.logOut();
    await _auth.signOut();
  }
}
