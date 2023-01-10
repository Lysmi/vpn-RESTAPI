import 'package:get_it/get_it.dart';

import '../entities/user.dart';
import '../repositories/users_repository_interface.dart';

class UserBalanceUsecase {
  IUsersRepository users = GetIt.I<IUsersRepository>();

  Future<int?> addBalanceToUser(int balance, String userId) async {
    var newUser = await users.getUserById(userId);
    if (newUser == null) {
      return null;
    }
    newUser.balance += balance;
    var res = await users.updateUser(newUser);
    return res?.balance;
  }
}
