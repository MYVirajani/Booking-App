import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031518),
      extendBody: true,
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 50, 24, 10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  "Our Facilities",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search nets or courts...",
                  hintStyle: TextStyle(color: Colors.white38),
                  prefixIcon: Icon(Icons.search, color: Color(0xFFB9F6CA)),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),


          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildFacilityCard(
                    "Cricket Net - Lane 01",
                    "Bowling machine available",
                    "LKR 1,500/hr",
                    Icons.sports_cricket_rounded
                ),
                _buildFacilityCard(
                    "Cricket Net - Lane 02",
                    "Spacious practice area",
                    "LKR 1,500/hr",
                    Icons.sports_cricket_outlined
                ),
                _buildFacilityCard(
                    "Futsal Court",
                    "High-grip indoor turf",
                    "LKR 3,500/hr",
                    Icons.sports_soccer_rounded
                ),
                _buildFacilityCard(
                    "Badminton Court A",
                    "Professional mat surface",
                    "LKR 1,200/hr",
                    Icons.sports_tennis_rounded
                ),
                _buildFacilityCard(
                    "Badminton Court B",
                    "Professional mat surface",
                    "LKR 1,200/hr",
                    Icons.sports_tennis_outlined
                ),
                _buildFacilityCard(
                    "Table Tennis",
                    "Double-table zone",
                    "LKR 800/hr",
                    Icons.sports_kabaddi_rounded
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildCustomBottomBar(),
    );
  }


  Widget _buildFacilityCard(String title, String desc, String price, IconData sportIcon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [

          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFB9F6CA).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(sportIcon, color: const Color(0xFFB9F6CA), size: 28),
          ),
          const SizedBox(width: 16),
          // Info Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
                const SizedBox(height: 6),
                Text(
                  price,
                  style: const TextStyle(color: Color(0xFFB9F6CA), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 14),
        ],
      ),
    );
  }


  Widget _buildCustomBottomBar() {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: Color(0xFF051C1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, "HOME", Icons.home_rounded),
          _buildNavItem(1, "BOOKINGS", Icons.calendar_month_rounded),
          _buildNavItem(2, "EXPLORE", Icons.search_rounded),
          _buildNavItem(3, "PROFILE", Icons.person_rounded),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String label, IconData icon) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? Colors.white : Colors.white38, size: 28),
          const SizedBox(height: 4),
          if (isSelected)
            Container(
              height: 4,
              width: 4,
              decoration: const BoxDecoration(color: Color(0xFFB9F6CA), shape: BoxShape.circle),
            ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFFB9F6CA) : Colors.white38,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}