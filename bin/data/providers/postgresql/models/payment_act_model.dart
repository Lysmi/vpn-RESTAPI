import 'package:stormberry/stormberry.dart';

import '../../../../domain/entities/payment_act.dart';
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

PaymentAct regionToEntity(PaymentActModel model) => PaymentAct(
      id: model.id,
      user: userToEntity(model.user),
      date: model.date,
      sum: model.sum,
    );
