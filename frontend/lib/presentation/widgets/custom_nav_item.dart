import 'package:flutter/material.dart';

class CustomNavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const CustomNavItem({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: onTap,
      child: Container(

        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white38,
              size: 28,
            ),
            const SizedBox(height: 4),

            Opacity(
              opacity: isSelected ? 1.0 : 0.0,
              child: Container(
                height: 4,
                width: 4,
                decoration: const BoxDecoration(
                  color: Color(0xFFB9F6CA),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFFB9F6CA) : Colors.white38,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}