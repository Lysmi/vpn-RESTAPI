import '../entities/server.dart';

abstract class IServerRepository {
  Future<List<Server>> getAllServers();
  Future<Server?> getServerById(String id);
  void addServer(Server user);
}
