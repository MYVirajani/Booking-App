import '../../data/models/user_model.dart';
import '../../data/repositories/auth/auth_repository.dart';

class AuthService {
  final AuthRepository repository;

  AuthService(this.repository);

  Future<UserModel> login(String email, String password) {
    return repository.login(email, password);
  }
}