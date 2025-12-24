import 'package:flutter/material.dart';
import 'package:npapp/controllers/auth_controller.dart';
import 'package:npapp/widgets/input_form.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final AuthController authController = AuthController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormInput(
              label: "Email",
              hint: "Enter your email",
              controller: email,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.isEmpty) return "Email is required";
                if (!v.contains("@")) return "Enter a valid email";
                return null;
              },
            ),
            FormInput(
              label: "Password",
              hint: "Create a password",
              obscureText: true,
              controller: password,
              validator: (v) {
                if (v == null || v.isEmpty) return "Password is required";
                if (v.length < 6) {
                  return "Minimum 6 characters required";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Create Account"),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    authController.signup(
                      context: context,
                      email: email.text,
                      password: password.text,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
