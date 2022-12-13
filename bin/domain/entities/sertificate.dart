import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:uuid/uuid.dart';

import 'server.dart';

@jsonSerializable
class Sertificate {
  String id;
  String privateKey;
  String publicKey;
  Server server;
  DateTime dateCreate;

  Sertificate(
      {required this.dateCreate,
      id,
      required this.privateKey,
      required this.publicKey,
      required this.server})
      : id = id ?? Uuid().v4();

  Sertificate copyWith({dateCreate, id, privateKey, publicKey, server}) {
    return Sertificate(
      dateCreate: dateCreate ?? this.dateCreate,
      id: id ?? this.id,
      privateKey: privateKey ?? this.privateKey,
      publicKey: publicKey ?? this.publicKey,
      server: server ?? this.server,
    );
  }
}
