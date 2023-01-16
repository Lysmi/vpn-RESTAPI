import 'package:firebase_dart/firebase_dart.dart';
import 'package:firebase_dart/implementation/testing.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/user.dart' as Entity;
import '../../../domain/entities/server.dart' as Entity;
import '../data_provider.dart';

class FirebaseData implements DataProvider {
  FirebaseDatabase? db;
  @override
  void addServer(Entity.Server server) {
    var ref = db!.reference().child("Servers");
    ref.update({server.id: server.toMap()});
  }

  @override
  void addUser(Entity.User user) {
    var ref = db!.reference().child("Users");
    ref.update({user.id: user.toMap()});
  }

  @override
  Future<List<Entity.Server>> getAllServers() async {
    var ref = db!.reference().child("Servers");
    var servers = await ref.get();
    if (servers == null) {
      return [];
    } else {
      servers as Map;
      servers = servers.values.toList();
      servers = (servers as List).map((e) => Entity.Server.fromMap(e)).toList();
    }
    return (servers as List<Entity.Server>);
  }

  @override
  Future<List<Entity.User>> getAllUsers() async {
    var ref = db!.reference().child("Users");
    var users = await ref.get();
    if (users == null) {
      return [];
    } else {
      users as Map;
      users = users.values.toList();
      users = (users as List).map((e) => Entity.User.fromMap(e)).toList();
    }
    return (users as List<Entity.User>);
  }

  @override
  Future<Entity.User?> getUserById(String id) async {
    var ref = db!.reference().child("Users/$id");
    var users = await ref.get();
    if (users == null) {
      return null;
    } else {
      return Entity.User.fromMap(users);
    }
  }

  @override
  void registration() async {
    db = GetIt.I<FirebaseDatabase>();
  }

  @override
  Entity.User updateUser(Entity.User user) {
    var ref = db!.reference().child("Users");
    ref.update({user.id: user.toMap()});
    return user;
  }
}
