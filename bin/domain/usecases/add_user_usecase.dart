// ignore_for_file: unnecessary_late

import 'package:get_it/get_it.dart';

import '../../external_connections/wireguard/wireguard_server.dart';
import '../entities/user.dart';
import '../repositories/servers_repository_interface.dart';
import '../repositories/users_repository_interface.dart';
import 'server_usecase.dart';

class AddUserUsecase {
  static late IUsersRepository users = GetIt.I<IUsersRepository>();
  static late IServerRepository servers = GetIt.I<IServerRepository>();

  static Future<String> addUser(User user) async {
    //add user sertificate to the server
    user = await generateNewSertificate(user);

    //add user to database
    users.addUser(user);

    return user.id;
  }

  static Future<User> generateNewSertificate(User user) async {
    var wireguardServer =
        WireguardServer(await ServerUsecase.chooseServer(user.region));
    user.currentCertificate = await wireguardServer.addNewPeer();
    return user;
  }
}
