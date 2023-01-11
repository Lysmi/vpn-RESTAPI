import '../entities/user.dart';

abstract class IUsersRepository {
  Future<List<User>> getAllUsers();
  Future<User?> getUserById(String id);
  Future<User?> getUserByTelegramId(String telegramId);
  Future<User?> updateUser(User user);
  void addUser(User user);
}
