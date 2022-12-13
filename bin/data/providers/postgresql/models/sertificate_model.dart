import 'package:stormberry/stormberry.dart';

import '../../../../domain/entities/sertificate.dart';
import 'server_model.dart';
import 'user_model.dart';

@Model()
abstract class SertificateModel {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  String get privateKey;
  String get publicKey;
  ServerModel get server;
  DateTime get dateCreate;
  UserModel get user;

  Sertificate toEntity() => Sertificate(
        id: id,
        dateCreate: dateCreate,
        privateKey: privateKey,
        publicKey: publicKey,
        server: server.toEntity(),
      );
}
