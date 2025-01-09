import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../models/user_model.dart';

class AppleAuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> signInWithApple() async {
    try {
      // Trigger the Apple Sign-In request
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Create OAuth Credential for Firebase
      final OAuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in to Firebase with Apple credential
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        return UserModel(
          displayName: user.displayName ?? appleCredential.givenName,
          email: user.email ?? appleCredential.email,
          photoURL: null, // Apple does not provide a profile picture
        );
      }
    } catch (e) {
      print("Error during Apple Sign-In: $e");
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
