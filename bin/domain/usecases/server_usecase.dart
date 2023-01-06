import 'package:get_it/get_it.dart';

import '../../external_connections/wireguard/wireguard_server.dart';
import '../../external_connections/wireguard/wireguard_server_interface.dart';
import '../entities/sertificate.dart';
import '../entities/server.dart';
import '../entities/user.dart';
import '../repositories/servers_repository_interface.dart';
import '../repositories/users_repository_interface.dart';

class ServerUsecase {
  IUsersRepository users = GetIt.I<IUsersRepository>();
  IServerRepository servers = GetIt.I<IServerRepository>();

  void addServer(Server server) async {
    servers.addServer(server);
  }

  Future<List<Server>> getServers() async {
    return servers.getAllServers();
  }
}
