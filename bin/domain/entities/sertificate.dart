import 'server.dart';

class Sertificate {
  int? id;
  String privateKey;
  String publicKey;
  Server server;
  DateTime dateCreate;

  Sertificate(
      {required this.dateCreate,
      this.id,
      required this.privateKey,
      required this.publicKey,
      required this.server});

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
