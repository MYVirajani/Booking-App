import 'package:flutter/material.dart';
import '../../widgets/category_card.dart';
import '../../widgets/main_nav_bar.dart';
import '../search/explore_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031518),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Good morning", style: TextStyle(color: Colors.white54, fontSize: 16)),
                      Text("Rain Sport Playground", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: Color(0xFF81D4FA),
                    child: Text("RS", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
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
                  image: NetworkImage('https://images.unsplash.com/photo-1544919982-b61976f0ba43?q=80&w=1000&auto=format&fit=crop'),
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

            // 3. FEATURED TEXT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("FEATURED VENUE", style: TextStyle(color: Color(0xFFB9F6CA), letterSpacing: 1.5, fontWeight: FontWeight.w600, fontSize: 12)),
                  Text("Book Your\nCourt Today", style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w900, height: 1.1)),
                ],
              ),
            ),

            // 4. STATS ROW
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  _buildStatCard("4", "COURTS"),
                  const SizedBox(width: 12),
                  _buildStatCard("24", "SLOTS LEFT"),
                  const SizedBox(width: 12),
                  _buildStatCard("4.9", "RATING"),
                ],
              ),
            ),

            // 5. CATEGORY HEADER
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 30, 24, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Select a Category", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ExploreScreen()));
                    },
                    child: const Text("View all →", style: TextStyle(color: Color(0xFFB9F6CA))),
                  ),
                ],
              ),
            ),

            // 6. CATEGORY LIST (Using reusable CategoryCard)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  CategoryCard(
                    title: "Cricket Net",
                    subtitle: "Lane 01 & 02 available",
                    price: "LKR 1,500/hr",
                    icon: Icons.sports_cricket_rounded,
                    onTap: () {
                      // Navigate to Cricket details or booking
                    },
                  ),
                  CategoryCard(
                    title: "Futsal Pitch",
                    subtitle: "Indoor High-grip turf",
                    price: "LKR 3,500/hr",
                    icon: Icons.sports_soccer_rounded,
                    onTap: () {},
                  ),
                  CategoryCard(
                    title: "Badminton",
                    subtitle: "Pro Mat Surfaces",
                    price: "LKR 1,200/hr",
                    icon: Icons.sports_tennis_rounded,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
      bottomNavigationBar: const MainNavBar(currentIndex: 0),
    );
  }

  // Helper: Stat Card (You can also move this to a separate class like CategoryCard!)
  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          children: [
            Text(value, style: const TextStyle(color: Color(0xFFB9F6CA), fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}