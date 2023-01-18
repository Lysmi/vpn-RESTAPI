import 'package:get_it/get_it.dart';

import '../../external_connections/wireguard/wireguard_server.dart';
import '../../external_connections/wireguard/wireguard_server_interface.dart';
import '../entities/sertificate.dart';
import '../entities/server.dart';
import '../entities/user.dart';
import '../repositories/servers_repository_interface.dart';
import '../repositories/users_repository_interface.dart';
import 'server_usecase.dart';

class AddUserUsecase {
  static late IUsersRepository users = GetIt.I<IUsersRepository>();
  static late IServerRepository servers = GetIt.I<IServerRepository>();

  static Future<String> addUsers(User user) async {
    //add user sertificate to the server
    user = await generateNewSertificate(user);

    //add user to database
    users.addUser(user);

    return user.id;
  }

  static Future<User> generateNewSertificate(User user) async {
    var wireguardServer = WireguardServer(await ServerUsecase.balanceServer());
    user.currentCertificate = await wireguardServer.addNewPeer();
    return user;
  }
}
