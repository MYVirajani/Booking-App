import 'package:flutter/material.dart';
import '../../widgets/category_card.dart';
import '../../widgets/main_nav_bar.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031518),
      extendBody: true,
      body: Column(
        children: [
          // 1. HEADER WITH BACK BUTTON
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

          // 2. SEARCH BAR
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

          // 3. FACILITY LIST (Using reusable CategoryCard)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                CategoryCard(
                  title: "Cricket Net - Lane 01",
                  subtitle: "Bowling machine available",
                  price: "LKR 1,500/hr",
                  icon: Icons.sports_cricket_rounded,
                  onTap: () {},
                ),
                CategoryCard(
                  title: "Cricket Net - Lane 02",
                  subtitle: "Spacious practice area",
                  price: "LKR 1,500/hr",
                  icon: Icons.sports_cricket_outlined,
                  onTap: () {},
                ),
                CategoryCard(
                  title: "Futsal Court",
                  subtitle: "High-grip indoor turf",
                  price: "LKR 3,500/hr",
                  icon: Icons.sports_soccer_rounded,
                  onTap: () {},
                ),
                CategoryCard(
                  title: "Badminton Court A",
                  subtitle: "Professional mat surface",
                  price: "LKR 1,200/hr",
                  icon: Icons.sports_tennis_rounded,
                  onTap: () {},
                ),
                CategoryCard(
                  title: "Badminton Court B",
                  subtitle: "Professional mat surface",
                  price: "LKR 1,200/hr",
                  icon: Icons.sports_tennis_outlined,
                  onTap: () {},
                ),
                CategoryCard(
                  title: "Table Tennis",
                  subtitle: "Double-table zone",
                  price: "LKR 800/hr",
                  icon: Icons.sports_kabaddi_rounded,
                  onTap: () {},
                ),
                const SizedBox(height: 120), // Padding for the floating nav bar
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: const MainNavBar(currentIndex: 2),
    );
  }
}