import '/data/models/user_model.dart';

class AuthRepository {
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));

    if (email == "test@gmail.com" && password == "1234") {
      return UserModel(email: email);
    } else {
      throw Exception("Invalid credentials");
    }
  }
}