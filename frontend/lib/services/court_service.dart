import '../core/api_client.dart';
import '../models/court.dart';

class CourtService {
  static Future<List<Court>> listCourts() async {
    final res = await ApiClient.get("/courts", auth: false);
    return (res as List).map((e) => Court.fromJson(e)).toList();
  }
}
