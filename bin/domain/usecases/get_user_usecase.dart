// ignore_for_file: unnecessary_late

import 'dart:typed_data';

import 'package:get_it/get_it.dart';

import '../../external_connections/wireguard/wireguard_server.dart';
import '../entities/user.dart';
import '../repositories/users_repository_interface.dart';

class GetUserUsecase {
  static late IUsersRepository userRep = GetIt.I<IUsersRepository>();

  static Future<List<User>> getAllUsers() {
    return userRep.getAllUsers();
  }

  static Future<User?> getUserById(String id) {
    return userRep.getUserById(id);
  }

  static Future<Uint8List?> getUserQR(String id) async {
    var userSertificate = (await userRep.getUserById(id))?.currentCertificate;
    if (userSertificate == null) {
      return null;
    }
    return WireguardServer(userSertificate.server)
        .getQRConfig(userSertificate.publicKey);
  }

  static Future<String?> getUserConfig(String id) async {
    var userSertificate = (await userRep.getUserById(id))?.currentCertificate;
    if (userSertificate == null) {
      return null;
    }
    return WireguardServer(userSertificate.server)
        .getConfig(userSertificate.publicKey);
  }
}
