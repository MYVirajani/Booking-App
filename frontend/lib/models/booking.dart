
class AvailabilitySlot {
  final DateTime startTime;
  final DateTime endTime;

  AvailabilitySlot({required this.startTime, required this.endTime});

  factory AvailabilitySlot.fromJson(Map<String, dynamic> json) => AvailabilitySlot(
    startTime: DateTime.parse(json["start_time"]).toLocal(),
    endTime: DateTime.parse(json["end_time"]).toLocal(),
  );

  bool overlaps(DateTime start, DateTime end) =>
      start.isBefore(endTime) && end.isAfter(startTime);
}

class Booking {
  final String id;
  final String courtId;
  final DateTime startTime;
  final DateTime endTime;
  final double totalAmount;
  final String status; // pending | confirmed | cancelled

  Booking({
    required this.id,
    required this.courtId,
    required this.startTime,
    required this.endTime,
    required this.totalAmount,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    courtId: json["court_id"],
    startTime: DateTime.parse(json["start_time"]).toLocal(),
    endTime: DateTime.parse(json["end_time"]).toLocal(),
    totalAmount: double.parse(json["total_amount"].toString()),
    status: json["status"],
  );

  bool get isUpcoming => status != "cancelled" && endTime.isAfter(DateTime.now());
}