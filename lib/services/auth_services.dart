// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // REGISTER NEW USER
  Future<Map<String, dynamic>> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      print("STATUS: Registering user…");

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("STATUS: Registration successful");
      return {
        "status": true,
        "message": "Registration successful",
        "user": userCredential.user,
      };
    } catch (e) {
      print("ERROR (registerUser): $e");
      return {"status": false, "message": e.toString()};
    }
  }

  // LOGIN USER
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      print("STATUS: Logging in…");

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("STATUS: Login successful");
      return {
        "status": true,
        "message": "Login successful",
        "user": userCredential.user,
      };
    } catch (e) {
      print("ERROR (loginUser): $e");
      return {"status": false, "message": e.toString()};
    }
  }

  // LOGOUT USER
  Future<Map<String, dynamic>> logoutUser() async {
    try {
      print("STATUS: Logging out…");
      await _auth.signOut();
      print("STATUS: Logout successful");
      return {"status": true, "message": "Logout successful"};
    } catch (e) {
      print("ERROR (logoutUser): $e");
      return {"status": false, "message": e.toString()};
    }
  }

  // RESET PASSWORD
  Future<Map<String, dynamic>> resetPassword(String email) async {
    try {
      print("STATUS: Sending reset password email…");
      await _auth.sendPasswordResetEmail(email: email);
      print("STATUS: Reset email sent");
      return {
        "status": true,
        "message": "Password reset email sent",
      };
    } catch (e) {
      print("ERROR (resetPassword): $e");
      return {"status": false, "message": e.toString()};
    }
  }

  // GET CURRENT USER
  User? getCurrentUser() {
    try {
      final user = _auth.currentUser;
      print("STATUS: Current user fetched -> ${user?.email}");
      return user;
    } catch (e) {
      print("ERROR (getCurrentUser): $e");
      return null;
    }
  }
}
