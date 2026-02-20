import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign in
  Future<User?> signInWithGoogle() async {

    final GoogleSignInAccount? googleUser =
    await _googleSignIn.signIn();

    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
    await _auth.signInWithCredential(credential);

    return userCredential.user;
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

}

========
import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Google Login")),

      body: Center(
        child: ElevatedButton(

          onPressed: () async {

            var user = await _authService.signInWithGoogle();
            user.email;

            if (user != null) {

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => HomeScreen(user),
                ),
              );

            }

          },

          child: Text("Sign in with Google"),
        ),
      ),
    );
  }
}

===
android/build.gradle
classpath 'com.google.gms:google-services:4.4.2'


android/app/build.gradle
apply plugin: 'com.google.gms.google-services'


Enable Google Sign-In in Firebase
Google → Enable → Save