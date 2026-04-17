import 'package:flutter/material.dart';
import '../../widgets/category_card.dart';
import '../../widgets/main_nav_bar.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {

  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031518),
      extendBody: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Padding(
            padding: EdgeInsets.fromLTRB(24, 60, 24, 20),
            child: Text(
              "My Bookings",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                _buildTabButton("Upcoming", 0),
                const SizedBox(width: 12),
                _buildTabButton("History", 1),
              ],
            ),
          ),

          const SizedBox(height: 20),


          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: _activeTab == 0 ? _buildUpcomingList() : _buildHistoryList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MainNavBar(currentIndex: 1),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isActive = _activeTab == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFB9F6CA) : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.white60,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildUpcomingList() {
    return [
      CategoryCard(
        title: "Cricket Net - Lane 01",
        subtitle: "Today • 04:00 PM - 05:00 PM",
        price: "Confirmed",
        icon: Icons.sports_cricket_rounded,
        onTap: () {},
      ),
      CategoryCard(
        title: "Futsal Pitch",
        subtitle: "Tomorrow • 08:00 PM",
        price: "Confirmed",
        icon: Icons.sports_soccer_rounded,
        onTap: () {},
      ),
      const SizedBox(height: 100),
    ];
  }

  List<Widget> _buildHistoryList() {
    return [
      CategoryCard(
        title: "Badminton Court A",
        subtitle: "12 April 2026",
        price: "Completed",
        icon: Icons.sports_tennis_rounded,
        onTap: () {},
      ),
      CategoryCard(
        title: "Cricket Net - Lane 02",
        subtitle: "08 April 2026",
        price: "Completed",
        icon: Icons.sports_cricket_outlined,
        onTap: () {},
      ),
      const SizedBox(height: 100),
    ];
  }
}