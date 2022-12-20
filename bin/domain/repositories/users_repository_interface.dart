import 'package:uuid/uuid.dart';

import '../entities/user.dart';

abstract class IUsersRepository {
  Future<List<User>> getAllUsers();
  Future<User?> getUserById(Uuid id);
}
