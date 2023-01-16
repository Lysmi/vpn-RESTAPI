import 'package:firebase_dart/firebase_dart.dart';
import 'package:firebase_dart/implementation/testing.dart';
import '../../../domain/entities/user.dart' as Entity;
import '../../../domain/entities/server.dart' as Entity;
import '../data_provider.dart';

class FirebaseData implements DataProvider {
  FirebaseApp? app;
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
    await FirebaseTesting.setup();
    var options = FirebaseOptions(
        appId: '1:567779820391:web:2471a31bdfa94ecfdd65c2',
        apiKey: 'AIzaSyBGyJHCcS-OyhdlgldtH0evXey321WJlN8',
        projectId: 'vpnrest-cbdd5',
        messagingSenderId: 'ignore',
        authDomain: 'vpnrest-cbdd5.firebaseapp.com');

    app = await Firebase.initializeApp(options: options);
    db = FirebaseDatabase(app: app, databaseURL: 'mem://user.database/');
  }

  @override
  Entity.User updateUser(Entity.User user) {
    var ref = db!.reference().child("Users");
    ref.update({user.id: user.toMap()});
    return user;
  }
}
