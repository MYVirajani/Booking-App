import 'package:flutter/material.dart';
import 'package:frontend/presentation/views/auth/signup_screen.dart';
import '../../widgets/custom_ui_components.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0F2027),
                  Color(0xFF203A43),
                  Color(0xFF2C5364),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Login", style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,)),

                  const SizedBox(height: 30),


                  CustomTextField(
                    controller: emailController,
                    hint: "Email",
                    icon: Icons.email,
                  ),

                  CustomTextField(
                    controller: passwordController,
                    hint: "Password",
                    icon: Icons.lock,
                    isPassword: true,
                  ),

                  const SizedBox(height: 20),

                  CustomPrimaryButton(
                    label: "LOGIN",
                    onTap: () {
                      print("Logging in with: ${emailController.text}");
                    },
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.white70),
                      ),
                      GestureDetector(
                        onTap: () =>
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupScreen())),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.lightGreenAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}