import '../entities/user.dart';

abstract class IUsersRepository {
  Future<List<User>> getAllUsers();
  Future<User?> getUserById(String id);
  void addUser(User user);
}
