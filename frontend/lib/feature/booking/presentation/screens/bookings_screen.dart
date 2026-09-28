import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/category_card.dart';
import '../../../../core/widgets/main_nav_bar.dart';
import '../../domain/booking.dart';
import '../bloc/my_bookings/my_booking_bloc.dart';
import '../bloc/my_bookings/my_booking_event.dart';
import '../bloc/my_bookings/my_booking_state.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyBookingsBloc()..add(MyBookingsRequested()),
      child: const _BookingsView(),
    );
  }
}

class _BookingsView extends StatefulWidget {
  const _BookingsView();

  @override
  State<_BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<_BookingsView> {
  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 20, 24, 20),
              child: Text("My Bookings", style: TextStyle(color: AppColors.textPrimary, fontSize: 28, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  _tabButton("Upcoming", 0),
                  const SizedBox(width: 12),
                  _tabButton("History", 1),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => context.read<MyBookingsBloc>().add(MyBookingsRequested()),
                child: BlocBuilder<MyBookingsBloc, MyBookingsState>(
                  builder: (context, state) {
                    if (state is MyBookingsLoading || state is MyBookingsInitial) {
                      return const Center(child: CircularProgressIndicator(color: AppColors.accent));
                    }
                    if (state is MyBookingsError) {
                      return ListView(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Center(child: Text(state.message, style: const TextStyle(color: AppColors.textMuted))),
                        ),
                      ]);
                    }
                    final all = (state as MyBookingsLoaded).bookings;
                    final list = _activeTab == 0 ? all.where((b) => b.isUpcoming).toList() : all.where((b) => !b.isUpcoming).toList();

                    if (list.isEmpty) {
                      return ListView(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 60),
                          child: Center(
                            child: Text(
                              _activeTab == 0 ? "No upcoming bookings yet." : "No past bookings.",
                              style: const TextStyle(color: AppColors.textMuted),
                            ),
                          ),
                        ),
                      ]);
                    }

                    return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      children: [
                        ...list.map((b) => CategoryCard(
                          title: "Court booking",
                          subtitle: _subtitleFor(b),
                          price: _statusLabel(b.status),
                          icon: Icons.sports_rounded,
                          onTap: () {},
                        )),
                        const SizedBox(height: 100),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MainNavBar(currentIndex: 1),
    );
  }

  String _subtitleFor(Booking b) {
    final date = "${b.startTime.day}/${b.startTime.month}/${b.startTime.year}";
    return "$date • ${_fmt(b.startTime)} - ${_fmt(b.endTime)}";
  }

  String _fmt(DateTime t) {
    final h = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final m = t.minute.toString().padLeft(2, '0');
    final period = t.hour >= 12 ? "PM" : "AM";
    return "$h:$m $period";
  }

  String _statusLabel(String status) {
    switch (status) {
      case "confirmed":
        return "Confirmed";
      case "pending":
        return "Awaiting payment";
      case "cancelled":
        return "Cancelled";
      default:
        return status;
    }
  }

  Widget _tabButton(String title, int index) {
    bool isActive = _activeTab == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.accent : AppColors.cardFill.withOpacity(0.05),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(title, style: TextStyle(color: isActive ? Colors.black : Colors.white60, fontWeight: FontWeight.bold, fontSize: 14)),
      ),
    );
  }
}