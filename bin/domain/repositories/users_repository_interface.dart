import '../entities/user.dart';

abstract class IUsersRepository {
  Future<List<User>> getAllUsers();
  Future<User?> getUserById(String id);
  Future<User?> updateUser(User user);
  void addUser(User user);
  Future<bool> removeUser(String id);
}
