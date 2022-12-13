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

  User toEntity() {
    return User(
      id: id,
      telegramId: telegramId,
      username: username,
      firstName: firstName,
      lastName: lastName,
      balance: balance,
      freePeriodUsed: freePeriodUsed,
      currentCertificate: currentCertificate.toEntity(),
    );
  }
}
