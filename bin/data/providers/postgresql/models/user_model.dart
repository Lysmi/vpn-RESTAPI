import 'package:stormberry/stormberry.dart';
import 'package:uuid/uuid.dart';

import '../../../../domain/entities/user.dart';
import 'sertificate_model.dart';

@Model(tableName: 'users')
abstract class UserModel {
  @PrimaryKey()
  Uuid get id;
  String get telegramId;
  String? get username;
  int get balance;
  bool get freePeriodUsed;
  // Uuid? get currentCertificateId;
  SertificateModel? get currentCertificate;
}

extension ToEntity on UserModel {
  User toEntity() => User(
        id: id,
        telegramId: telegramId,
        username: username ?? '',
        balance: balance,
        freePeriodUsed: freePeriodUsed,
        currentCertificate: currentCertificate?.toEntity(),
      );
}
