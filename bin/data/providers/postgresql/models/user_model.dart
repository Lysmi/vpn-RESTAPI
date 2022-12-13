import 'package:stormberry/stormberry.dart';

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
