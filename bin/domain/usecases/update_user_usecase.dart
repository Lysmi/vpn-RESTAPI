import 'package:get_it/get_it.dart';

import '../entities/region.dart';
import '../entities/user.dart';
import '../repositories/users_repository_interface.dart';

class UpdateUserUsecase {
  static late IUsersRepository usersRep = GetIt.I<IUsersRepository>();

  static Future<User?> changeUserRegion(Region region, String userId) async {
    var newUser = await usersRep.getUserById(userId);
    if (newUser != null) {
      newUser.region = region;
      usersRep.updateUser(newUser);
    }
    return newUser;
  }
}
