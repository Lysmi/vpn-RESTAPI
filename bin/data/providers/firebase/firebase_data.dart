import 'package:firebase_dart/firebase_dart.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/region.dart' as entity;
import '../../../domain/entities/user.dart' as entity;
import '../../../domain/entities/server.dart' as entity;
import '../data_provider.dart';

class FirebaseData implements DataProvider {
  FirebaseDatabase? db;
  @override
  void addServer(entity.Server server) {
    var ref = db!.reference().child("Servers");
    ref.update({server.id: server.toMap()});
  }

  @override
  void addUser(entity.User user) {
    var ref = db!.reference().child("Users");
    ref.update({user.id: user.toMap()});
  }

  @override
  Future<List<entity.Server>> getAllServers() async {
    var ref = db!.reference().child("Servers");
    var servers = await ref.get();
    if (servers == null || servers == "") {
      return [];
    } else {
      servers as Map;
      servers = servers.values.toList();
      servers = (servers as List).map((e) => entity.Server.fromMap(e)).toList();
    }
    return (servers as List<entity.Server>);
  }

  @override
  Future<List<entity.User>> getAllUsers() async {
    var ref = db!.reference().child("Users");
    var users = await ref.get();
    if (users == null || users == "") {
      return [];
    } else {
      users as Map;
      users = users.values.toList();
      users = (users as List).map((e) => entity.User.fromMap(e)).toList();
    }
    return (users as List<entity.User>);
  }

  @override
  Future<entity.User?> getUserById(String id) async {
    var ref = db!.reference().child("Users/$id");
    var users = await ref.get();
    if (users == null) {
      return null;
    } else {
      return entity.User.fromMap(users);
    }
  }

  @override
  void registration() async {
    db = GetIt.I<FirebaseDatabase>();
  }

  @override
  entity.User updateUser(entity.User user) {
    var ref = db!.reference().child("Users");
    ref.update({user.id: user.toMap()});
    return user;
  }

  @override
  void removeUser(String id) {
    var ref = db!.reference().child("Users/$id");
    ref.remove();
  }

  @override
  void addRegion(entity.Region region) {
    var ref = db!.reference().child("Regions");
    ref.update({region.id: region.toMap()});
  }

  @override
  Future<List<entity.Region>> getAllRegions() async {
    var ref = db!.reference().child("Regions");
    var regions = await ref.get();
    if (regions == null || regions == "") {
      return [];
    } else {
      regions as Map;
      regions = regions.values.toList();
      regions = (regions as List).map((e) => entity.Region.fromMap(e)).toList();
    }
    return (regions as List<entity.Region>);
  }

  @override
  Future<entity.Region?> getRegionById(String id) async {
    var ref = db!.reference().child("Regions/$id");
    var users = await ref.get();
    if (users == null) {
      return null;
    } else {
      return entity.Region.fromMap(users);
    }
  }
}
