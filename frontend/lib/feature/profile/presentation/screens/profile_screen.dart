import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/main_nav_bar.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../court/presentation/screens/welcome_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        extendBody: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final user = state is AuthAuthenticated ? state.user : null;
                    return Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                          ),
                        ),
                        Positioned(
                          top: 130,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: AppColors.background,
                                  child: Text(
                                    user?.initials ?? "..",
                                    style: const TextStyle(color: AppColors.accent, fontSize: 32, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(user?.name ?? "Loading...",
                                  style: const TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold)),
                              Text(user?.phone ?? "", style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 120),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      _option(Icons.person_outline_rounded, "Personal Information"),
                      _option(Icons.payment_rounded, "Payment Methods"),
                      _option(Icons.notifications_none_rounded, "Notifications"),
                      _option(Icons.history_rounded, "Booking History"),
                      _option(Icons.help_outline_rounded, "Support & FAQ"),
                      const SizedBox(height: 20),
                      TextButton.icon(
                        onPressed: () => context.read<AuthBloc>().add(AuthLogoutRequested()),
                        icon: const Icon(Icons.logout_rounded, color: AppColors.danger),
                        label: const Text("Logout", style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const MainNavBar(currentIndex: 3),
      ),
    );
  }

  Widget _option(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: AppColors.cardFill.withOpacity(0.05), borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Icon(icon, color: AppColors.accent),
        title: Text(title, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
        onTap: () {},
      ),
    );
  }
}