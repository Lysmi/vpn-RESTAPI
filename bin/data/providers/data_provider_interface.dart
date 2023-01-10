import '../../domain/entities/server.dart';
import '../../domain/entities/user.dart';

abstract class DataProvider {
  Future<List<User>> getAllUsers();
  Future<User?> getUserById(String id);
  void addUser(User user);
  Future<List<Server>> getAllServers();
  void addServer(Server server);
  void registration();
}
