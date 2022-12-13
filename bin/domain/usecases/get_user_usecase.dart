import 'package:get_it/get_it.dart';

import '../entities/user.dart';
import '../repositories/users_repository_interface.dart';

class GetUserUsecase {
  IUsersRepository userRep = GetIt.I<IUsersRepository>();
  List<User> getAllUsers() {
    return userRep.getAllUsers();
  }

  User getUserById(int id) {
    return userRep.getUserById(id);
  }
}
