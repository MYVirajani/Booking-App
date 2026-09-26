import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/category_card.dart';
import '../../../../core/widgets/main_nav_bar.dart';
import '../../../booking/presentation/screens/slot_picker_screen.dart';
import '../../domain/court.dart';
import '../bloc/court_bloc.dart';
import '../bloc/court_event.dart';
import '../bloc/court_state.dart';
import 'explore_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CourtBloc()..add(CourtListRequested()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        extendBody: true,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async => context.read<CourtBloc>().add(CourtListRequested()),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(24, 40, 24, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Good to see you", style: TextStyle(color: AppColors.textSecondary, fontSize: 16)),
                        Text("Book a Court",
                            style: TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1544919982-b61976f0ba43?q=80&w=1000&auto=format&fit=crop',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("FEATURED VENUE",
                            style: TextStyle(color: AppColors.accent, letterSpacing: 1.5, fontWeight: FontWeight.w600, fontSize: 12)),
                        Text("Book Your\nCourt Today",
                            style: TextStyle(color: AppColors.textPrimary, fontSize: 42, fontWeight: FontWeight.w900, height: 1.1)),
                      ],
                    ),
                  ),
                  BlocBuilder<CourtBloc, CourtState>(
                    builder: (context, state) {
                      final courts = state is CourtLoaded ? state.courts : <Court>[];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            _statCard(courts.length.toString(), "COURTS"),
                            const SizedBox(width: 12),
                            _statCard(courts.where((c) => c.isActive).length.toString(), "AVAILABLE"),
                            const SizedBox(width: 12),
                            _statCard("4.9", "RATING"),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 30, 24, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Select a Category",
                            style: TextStyle(color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ExploreScreen())),
                          child: const Text("View all →", style: TextStyle(color: AppColors.accent)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: BlocBuilder<CourtBloc, CourtState>(
                      builder: (context, state) {
                        if (state is CourtLoading || state is CourtInitial) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: Center(child: CircularProgressIndicator(color: AppColors.accent)),
                          );
                        }
                        if (state is CourtError) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(state.message, style: const TextStyle(color: AppColors.textMuted)),
                          );
                        }
                        final courts = (state as CourtLoaded).courts.take(3).toList();
                        return Column(
                          children: courts
                              .map((court) => CategoryCard(
                            title: court.name,
                            subtitle: court.subtitleLabel,
                            price: court.priceLabel,
                            icon: court.icon,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SlotPickerScreen(court: court)),
                            ),
                          ))
                              .toList(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const MainNavBar(currentIndex: 0),
      ),
    );
  }

  Widget _statCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(color: AppColors.cardFill.withOpacity(0.05), borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text(value, style: const TextStyle(color: AppColors.accent, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}