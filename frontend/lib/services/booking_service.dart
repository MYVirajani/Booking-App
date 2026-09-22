import '../core/api_client.dart';
import '../models/booking.dart';

class BookingService {
  static Future<List<AvailabilitySlot>> getAvailability({
    required String courtId,
    required DateTime date,
  }) async {
    final dateStr =
        "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    final res = await ApiClient.get(
      "/bookings/availability?court_id=$courtId&booking_date=$dateStr",
      auth: false,
    );
    return (res as List).map((e) => AvailabilitySlot.fromJson(e)).toList();
  }


  static Future<Booking> createBooking({
    required String courtId,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final res = await ApiClient.post(
      "/bookings",
      body: {
        "court_id": courtId,
        "start_time": startTime.toUtc().toIso8601String(),
        "end_time": endTime.toUtc().toIso8601String(),
      },
    );
    return Booking.fromJson(res);
  }

  static Future<List<Booking>> myBookings() async {
    final res = await ApiClient.get("/bookings/me");
    return (res as List).map((e) => Booking.fromJson(e)).toList();
  }

  static Future<void> cancelBooking(String bookingId) async {
    await ApiClient.post("/bookings/$bookingId/cancel");
  }
}
