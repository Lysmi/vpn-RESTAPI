import 'package:stormberry/stormberry.dart';

import '../../../../domain/entities/user.dart';
import 'sertificate_model.dart';

@Model(tableName: 'users')
abstract class UserModel {
  @PrimaryKey()
  String get id;
  String get telegramId;
  String? get username;
  int get balance;
  bool get freePeriodUsed;
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
