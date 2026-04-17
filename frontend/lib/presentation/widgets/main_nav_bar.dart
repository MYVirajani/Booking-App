import 'package:flutter/material.dart';
import 'package:frontend/presentation/views/bookings/bookings_screen.dart';
import '../views/get_started/home_screen.dart';
import '../views/search/explore_screen.dart';
import 'custom_nav_item.dart';

class MainNavBar extends StatelessWidget {
  final int currentIndex;

  const MainNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: const Color(0xFF051C1F),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomNavItem(
            index: 0,
            currentIndex: currentIndex,
            label: "HOME",
            icon: Icons.home_rounded,
            onTap: () => _navigate(context, 0),
          ),
          CustomNavItem(
            index: 1,
            currentIndex: currentIndex,
            label: "BOOKINGS",
            icon: Icons.calendar_month_rounded,
            onTap: () => _navigate(context, 1),
          ),
          CustomNavItem(
            index: 2,
            currentIndex: currentIndex,
            label: "EXPLORE",
            icon: Icons.search_rounded,
            onTap: () => _navigate(context, 2),
          ),
          CustomNavItem(
            index: 3,
            currentIndex: currentIndex,
            label: "PROFILE",
            icon: Icons.person_rounded,
            onTap: () => _navigate(context, 3),
          ),
        ],
      ),
    );
  }

  void _navigate(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = const HomeScreen();
        break;
      case 1:
        nextScreen = const BookingsScreen();
        break;
      case 2:
        nextScreen = const ExploreScreen();
        break;

      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => nextScreen,
        transitionDuration: Duration.zero, // Fast switch for nav bar
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}