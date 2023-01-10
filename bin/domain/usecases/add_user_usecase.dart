import 'package:get_it/get_it.dart';

import '../../external_connections/wireguard/wireguard_server.dart';
import '../../external_connections/wireguard/wireguard_server_interface.dart';
import '../entities/sertificate.dart';
import '../entities/server.dart';
import '../entities/user.dart';
import '../repositories/servers_repository_interface.dart';
import '../repositories/users_repository_interface.dart';

class AddUserUsecase {
  IUsersRepository users = GetIt.I<IUsersRepository>();
  IServerRepository servers = GetIt.I<IServerRepository>();

  Future<String> addUsers(User user) async {
    //add user sertificate to the server
    var wireguardServer = WireguardServer(await _balanceServer());
    user.currentCertificate = await wireguardServer.addNewPeer();

    //add user to database
    users.addUser(user);

    return user.id;
  }

  Future<Server> _balanceServer() async {
    var serversList = (await servers.getAllServers());
    serversList.sort(((a, b) => a.countUsers.compareTo(b.countUsers)));
    if (serversList.isEmpty) {
      throw Exception("EmptyServerList");
    } else {
      return serversList.first;
    }
  }
}
