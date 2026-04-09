import 'package:flutter/material.dart';
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
                children: [
                  const Text("Login", style: TextStyle(color: Colors.white, fontSize: 28)),

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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}