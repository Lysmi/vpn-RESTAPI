import 'package:get_it/get_it.dart';

import '../../external_connections/wireguard/wireguard_server.dart';
import '../../external_connections/wireguard/wireguard_server_interface.dart';
import '../entities/sertificate.dart';
import '../entities/server.dart';
import '../entities/user.dart';
import '../repositories/servers_repository_interface.dart';
import '../repositories/users_repository_interface.dart';

class ServerUsecase {
  static late IServerRepository servers = GetIt.I<IServerRepository>();

  static void addServer(Server server) async {
    servers.addServer(server);
  }

  static Future<List<Server>> getServers() async {
    return servers.getAllServers();
  }

  static Future<Server> balanceServer() async {
    var serversList = (await servers.getAllServers());
    serversList.sort(((a, b) => a.countUsers.compareTo(b.countUsers)));
    if (serversList.isEmpty) {
      throw Exception("EmptyServerList");
    } else {
      return serversList.first;
    }
  }
}
