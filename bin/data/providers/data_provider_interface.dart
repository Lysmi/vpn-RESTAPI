import 'package:uuid/uuid.dart';

import '../../domain/entities/user.dart';

abstract class IDataProvider {
  Future<List<User>> getAllUsers();
  Future<User?> getUserById(Uuid id);
}