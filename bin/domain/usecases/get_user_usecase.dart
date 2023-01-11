import 'dart:typed_data';

import 'package:get_it/get_it.dart';

import '../../external_connections/wireguard/wireguard_server.dart';
import '../entities/user.dart';
import '../repositories/users_repository_interface.dart';

class GetUserUsecase {
  IUsersRepository userRep = GetIt.I<IUsersRepository>();
  Future<List<User>> getAllUsers() {
    return userRep.getAllUsers();
  }

  Future<User?> getUserById(String id) {
    return userRep.getUserById(id);
  }

  Future<Uint8List?> getUserQR(String id) async {
    var user = await userRep.getUserById(id);
    if (user == null) {
      return null;
    }
    return WireguardServer(user.currentCertificate!.server)
        .getQRConfig(user.currentCertificate!.publicKey);
  }
}
