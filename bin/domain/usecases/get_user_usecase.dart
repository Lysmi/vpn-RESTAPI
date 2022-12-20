import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

import '../entities/user.dart';
import '../repositories/users_repository_interface.dart';

class GetUserUsecase {
  final IUsersRepository _userRep = GetIt.I<IUsersRepository>();
  
  Future<List<User>> getAllUsers() {
    return _userRep.getAllUsers();
  }

  Future<User?> getUserById(Uuid id) {
    return _userRep.getUserById(id);
  }
}
