import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.welcomeGradient),
        child: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthRegisterSuccess) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Account created - log in to continue")),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is AuthLoading;
              final error = state is AuthFailure ? state.message : null;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      "Create Account",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Sign up to start booking courts.",
                      style: TextStyle(color: AppColors.textPrimary.withOpacity(0.7), fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(controller: _nameController, hint: "Full name", icon: Icons.person_outline),
                    CustomTextField(
                      controller: _phoneController,
                      hint: "Phone number",
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    CustomTextField(
                      controller: _emailController,
                      hint: "Email (optional)",
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      hint: "Password",
                      icon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    if (error != null) ...[
                      const SizedBox(height: 8),
                      Text(error, style: const TextStyle(color: AppColors.danger, fontSize: 13)),
                    ],
                    const SizedBox(height: 20),
                    CustomPrimaryButton(
                      label: "SIGN UP",
                      isLoading: isLoading,
                      onTap: () => context.read<AuthBloc>().add(AuthRegisterRequested(
                        name: _nameController.text.trim(),
                        phone: _phoneController.text.trim(),
                        password: _passwordController.text,
                        email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
                      )),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}