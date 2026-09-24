import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/category_card.dart';
import '../../domain/court.dart';
import '../../data/court_service.dart';
import '../../../../core/widgets/main_nav_bar.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late Future<List<Court>> _courtsFuture;
  String _query = "";

  @override
  void initState() {
    super.initState();
    _courtsFuture = CourtService.listCourts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 24, 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Our Facilities",
                    style: TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.cardFill.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.cardFill.withOpacity(0.08)),
                ),
                child: TextField(
                  style: const TextStyle(color: AppColors.textPrimary),
                  onChanged: (value) => setState(() => _query = value.toLowerCase()),
                  decoration: const InputDecoration(
                    hintText: "Search nets or courts...",
                    hintStyle: TextStyle(color: AppColors.textMuted),
                    prefixIcon: Icon(Icons.search, color: AppColors.accent),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Court>>(
                future: _courtsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.accent));
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Couldn't load courts.", style: TextStyle(color: AppColors.textMuted)),
                    );
                  }
                  final courts = (snapshot.data ?? [])
                      .where((c) => c.name.toLowerCase().contains(_query))
                      .toList();
                  if (courts.isEmpty) {
                    return const Center(
                      child: Text("No courts match your search.", style: TextStyle(color: AppColors.textMuted)),
                    );
                  }
                  return ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      ...courts.map((court) => CategoryCard(
                        title: court.name,
                        subtitle: court.subtitleLabel,
                        price: court.priceLabel,
                        icon: court.icon,
                          onTap: () {}
                      )),
                      const SizedBox(height: 120),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MainNavBar(currentIndex: 2),
    );
  }
}
