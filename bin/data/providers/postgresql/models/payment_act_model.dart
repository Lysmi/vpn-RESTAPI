import 'package:stormberry/stormberry.dart';

import 'user_model.dart';

@Model()
abstract class PaymentActModel {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  UserModel get user;
  int get sum;
  DateTime get date;
}
