// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:npapp/presentation/auth/auth.dart';
import 'package:npapp/presentation/siraat/siraat.dart';
import 'package:npapp/services/auth_services.dart';

class AuthController {
  final AuthServices _authServices = AuthServices();

  /// AUTH GATEWAY
  Future<void> checkAuthAndNavigate(BuildContext context) async {
    try {
      final user = _authServices.getCurrentUser();

      if (user != null) {
        debugPrint("AUTH | User logged in: ${user.email}");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Siraat()),
        );
      } else {
        debugPrint("AUTH | No user logged in");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AuthScreen()),
        );
      }
    } catch (e) {
      debugPrint("AUTH | Auth check failed: $e");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthScreen()),
      );
    }
  }

  /// LOGIN
  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    debugPrint("AUTH | Attempting Login");

    try {
      final res = await _authServices.loginUser(
        email: email.trim(),
        password: password.trim(),
      );

      if (res["status"] == true) {
        debugPrint("AUTH | Login Success");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Siraat()),
        );
      } else {
        debugPrint("AUTH | Login Failed");
        _showSnack(context, res["message"]);
      }
    } catch (e) {
      debugPrint("AUTH | Login Exception: $e");
      _showSnack(context, "Login failed. Please try again.");
    }
  }

  /// SIGNUP
  Future<void> signup({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    debugPrint("AUTH | Attempting Signup");

    try {
      final res = await _authServices.registerUser(
        email: email.trim(),
        password: password.trim(),
      );

      if (res["status"] == true) {
        debugPrint("AUTH | Signup Success");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Siraat()),
        );
      } else {
        debugPrint("AUTH | Signup Failed");
        _showSnack(context, res["message"]);
      }
    } catch (e) {
      debugPrint("AUTH | Signup Exception: $e");
      _showSnack(context, "Signup failed. Please try again.");
    }
  }

  /// LOGOUT
  Future<void> logout(BuildContext context) async {
    debugPrint("AUTH | Attempting Logout");

    try {
      final res = await _authServices.logoutUser();

      if (res["status"] == true) {
        debugPrint("AUTH | Logout Success");

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AuthScreen()),
          (route) => false,
        );
      } else {
        debugPrint("AUTH | Logout Failed");
        _showSnack(context, res["message"]);
      }
    } catch (e) {
      debugPrint("AUTH | Logout Exception: $e");
      _showSnack(context, "Logout failed.");
    }
  }

  /// RESET PASSWORD
  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    debugPrint("AUTH | Reset Password");

    try {
      final res = await _authServices.resetPassword(email.trim());

      _showSnack(context, res["message"]);
    } catch (e) {
      debugPrint("AUTH | Reset Exception: $e");
      _showSnack(context, "Unable to reset password.");
    }
  }

  /// CURRENT USER
  User? get currentUser => _authServices.getCurrentUser();

  /// COMMON SNACKBAR
  void _showSnack(BuildContext context, String? message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message ?? "Something went wrong")));
  }
}
