import 'package:get_it/get_it.dart';

import '../entities/region.dart';
import '../entities/user.dart';
import '../repositories/users_repository_interface.dart';
import 'add_user_usecase.dart';

class UpdateUserUsecase {
  static late IUsersRepository usersRep = GetIt.I<IUsersRepository>();

  static Future<User?> changeUserRegion(Region region, String userId) async {
    var newUser = await usersRep.getUserById(userId);
    if (newUser != null) {
      newUser.region = region;
      await AddUserUsecase.generateNewSertificate(newUser);
      usersRep.updateUser(newUser);
    }
    return newUser;
  }
}
