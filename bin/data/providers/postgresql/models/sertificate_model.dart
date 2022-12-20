import 'package:stormberry/stormberry.dart';
import 'package:uuid/uuid.dart';

import '../../../../domain/entities/sertificate.dart';
import 'server_model.dart';
import 'user_model.dart';

@Model(tableName: 'sertificates')
abstract class SertificateModel {
  @PrimaryKey()
  Uuid get id;
  String get privateKey;
  String get publicKey;
  ServerModel get server;
  DateTime get dateCreate;
  UserModel get user;
}

extension ToEntity on SertificateModel {
  Sertificate toEntity() => Sertificate(
        id: id,
        dateCreate: dateCreate,
        privateKey: privateKey,
        publicKey: publicKey,
        server: server.toEntity(),
      );
}
