
class AppUser {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final bool isOwner;

  AppUser({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    required this.isOwner,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    isOwner: json["is_owner"] ?? false,
  );

  String get initials {
    final parts = name.trim().split(RegExp(r"\s+"));
    if (parts.isEmpty) return "?";
    if (parts.length == 1) return parts[0].substring(0, 1).toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}