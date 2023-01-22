// ignore_for_file: unnecessary_late

import 'package:get_it/get_it.dart';

import '../../external_connections/wireguard/wireguard_server.dart';
import '../entities/user.dart';
import '../repositories/users_repository_interface.dart';
import 'add_user_usecase.dart';

class UserBalanceUsecase {
  static late IUsersRepository usersRep = GetIt.I<IUsersRepository>();

  static Future<int?> addBalanceToUser(int balance, String userId) async {
    var newUser = await usersRep.getUserById(userId);
    if (newUser == null) {
      return null;
    }
    newUser.balance += balance;
    if (newUser.balance <= 0) {
      newUser.balance = 0;
    }
    newUser = await _generateNewSerificateWithBalanceCheck(newUser);
    var res = await usersRep.updateUser(newUser);
    return res?.balance;
  }

  static Future<int?> useFreePeriod(String userId) async {
    var newUser = await usersRep.getUserById(userId);
    if (newUser == null) {
      return null;
    }
    if (newUser.freePeriodUsed) {
      return -1;
    }
    newUser.freePeriodUsed = true;
    newUser.balance += 3;
    if (newUser.balance <= 0) {
      newUser.balance = 0;
    }
    newUser = await _generateNewSerificateWithBalanceCheck(newUser);
    var res = await usersRep.updateUser(newUser);
    return res?.balance;
  }

  static Future<void> addBalanceToAllUsers(int balance) async {
    var newUsers = await usersRep.getAllUsers();
    for (var newUser in newUsers) {
      newUser.balance += balance;
      if (newUser.balance <= 0) {
        newUser.balance = 0;
      }
      newUser = await _generateNewSerificateWithBalanceCheck(newUser);

      usersRep.updateUser(newUser);
    }
  }

  static void dailyDeacreaseBalance() async {
    addBalanceToAllUsers(-1);
    var users = await usersRep.getAllUsers();
    for (var user in users) {
      if (user.balance <= 0) {
        var sertificate = user.currentCertificate;
        if (sertificate != null) {
          WireguardServer(sertificate.server).deletePeer(sertificate.publicKey);
          user.currentCertificate = null;
        }
      }
    }
  }

  static Future<User> _generateNewSerificateWithBalanceCheck(User user) async {
    if (user.balance > 0 && user.currentCertificate == null) {
      user = await AddUserUsecase.generateNewSertificate(user);
    }
    return user;
  }
}
