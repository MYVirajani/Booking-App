import '../../../core/network/api_client.dart';
import '../../../core/storage/token_storage.dart';
import '../domain/user.dart';

class AuthService {
  static Future<void> register({
    required String name,
    required String phone,
    required String password,
    String? email,
  }) async {
    await ApiClient.post(
      "/auth/register",
      auth: false,
      body: {"name": name, "phone": phone, "password": password, "email": email},
    );
  }

  static Future<void> login({required String phone, required String password}) async {
    final res = await ApiClient.post(
      "/auth/login",
      auth: false,
      body: {"phone": phone, "password": password},
    );
    await TokenStorage.save(res["access_token"]);
  }

  static Future<void> logout() => TokenStorage.clear();

  static Future<bool> isLoggedIn() async => (await TokenStorage.read()) != null;

  static Future<AppUser> getMe() async {
    final res = await ApiClient.get("/auth/me");
    return AppUser.fromJson(res);
  }
}
