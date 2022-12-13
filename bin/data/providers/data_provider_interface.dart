import '../../domain/entities/user.dart';

abstract class IDataProvider {
  List<User> getAllUsers();
  User getUserById(int id);
}
