import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_colors.dart';
import 'feature/auth/presentation/bloc/auth_bloc.dart';
import 'feature/auth/presentation/bloc/auth_event.dart';
import 'feature/auth/presentation/bloc/auth_state.dart';
import 'feature/court/presentation/screens/home_screen.dart';
import 'feature/court/presentation/screens/welcome_screen.dart';

void main() {
  runApp(const PlaygroundBookingApp());
}

class PlaygroundBookingApp extends StatelessWidget {
  const PlaygroundBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc()..add(AuthSessionCheckRequested()),
      child: MaterialApp(
        title: 'Playground Booking',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accent, brightness: Brightness.dark),
        ),
        home: const _StartupGate(),
      ),
    );
  }
}

class _StartupGate extends StatelessWidget {
  const _StartupGate();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) return const HomeScreen();
        if (state is AuthUnauthenticated) return const WelcomeScreen();
        return const Scaffold(
          backgroundColor: AppColors.background,
          body: Center(child: CircularProgressIndicator(color: AppColors.accent)),
        );
      },
    );
  }
}