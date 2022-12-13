import 'package:stormberry/stormberry.dart';

import '../../../../domain/entities/user.dart';
import 'sertificate_model.dart';

@Model()
abstract class UserModel {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  String get telegramId;
  String get username;
  String get firstName;
  String get lastName;
  int get balance;
  bool get freePeriodUsed;
  SertificateModel get currentCertificate;
}

User userToEntity(UserModel model) => User(
      id: model.id,
      telegramId: model.telegramId,
      username: model.username,
      firstName: model.firstName,
      lastName: model.lastName,
      balance: model.balance,
      freePeriodUsed: model.freePeriodUsed,
      currentCertificate: sertificateToEntity(model.currentCertificate),
    );
