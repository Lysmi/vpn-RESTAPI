import '../entities/user.dart';

abstract class IUsersRepository {
  List<User> getAllUsers();
  User getUserById(int id);
}
