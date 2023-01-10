import 'package:get_it/get_it.dart';

import '../../domain/entities/server.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/servers_repository_interface.dart';
import '../../domain/repositories/users_repository_interface.dart';
import '../providers/data_provider_interface.dart';

class ServerRepository extends IServerRepository {
  final DataProvider _dataProvider = GetIt.I<DataProvider>();

  @override
  void addServer(Server server) {
    _dataProvider.addServer(server);
  }

  @override
  Future<List<Server>> getAllServers() {
    return _dataProvider.getAllServers();
  }

  @override
  Future<Server?> getServerById(String id) {
    // TODO: implement getServerById
    throw UnimplementedError();
  }
}
