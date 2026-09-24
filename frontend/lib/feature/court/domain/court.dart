import 'package:flutter/material.dart';

class Court {
  final String id;
  final String name;
  final String sportType;
  final double ratePerHour;
  final bool isActive;

  Court({
    required this.id,
    required this.name,
    required this.sportType,
    required this.ratePerHour,
    required this.isActive,
  });

  factory Court.fromJson(Map<String, dynamic> json) => Court(
    id: json["id"],
    name: json["name"],
    sportType: json["sport_type"],
    ratePerHour: double.parse(json["rate_per_hour"].toString()),
    isActive: json["is_active"] ?? true,
  );

  String get priceLabel => "LKR ${ratePerHour.toStringAsFixed(0)}/hr";


  IconData get icon {
    switch (sportType) {
      case "cricket":
        return Icons.sports_cricket_rounded;
      case "futsal":
        return Icons.sports_soccer_rounded;
      case "tennis":
        return Icons.sports_tennis_rounded;
      case "badminton":
        return Icons.sports_tennis_outlined;
      case "netball":
        return Icons.sports_basketball_rounded;
      default:
        return Icons.sports_kabaddi_rounded;
    }
  }

  String get subtitleLabel {
    switch (sportType) {
      case "cricket":
        return "Indoor practice net";
      case "futsal":
        return "High-grip indoor turf";
      case "tennis":
        return "Pro court surface";
      case "badminton":
        return "Professional mat surface";
      case "netball":
        return "Full-size indoor court";
      default:
        return "Indoor court";
    }
  }
}