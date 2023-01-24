import '../../domain/entities/region.dart';
import '../../domain/entities/server.dart';
import '../../domain/entities/user.dart';

abstract class DataProvider {
  Future<List<User>> getAllUsers();
  Future<User?> getUserById(String id);
  Future<Region?> getRegionById(String id);
  Future<List<Region>> getAllRegions();
  void addUser(User user);
  Future<List<Server>> getAllServers();
  void addServer(Server server);
  void addRegion(Region region);
  User updateUser(User user);
  void registration();
  void removeUser(String id);
}
