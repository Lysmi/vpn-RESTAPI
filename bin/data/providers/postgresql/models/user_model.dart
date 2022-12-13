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

User userToEntity(UserModel model) => User(
      id: model.id,
      telegramId: model.telegramId,
      username: model.username ?? '',
      balance: model.balance,
      freePeriodUsed: model.freePeriodUsed,
      currentCertificate: sertificateToEntity(model.currentCertificate ?? null),
    );
