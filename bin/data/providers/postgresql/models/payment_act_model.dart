import 'package:stormberry/stormberry.dart';
import 'package:uuid/uuid.dart';

import '../../../../domain/entities/payment_act.dart';
import 'user_model.dart';

@Model(tableName: 'payment_acts')
abstract class PaymentActModel {
  @PrimaryKey()
  Uuid get id;
  UserModel get user;
  int get sum;
  DateTime get date;
}

extension ToEntity on PaymentActModel {
  toEntity() => PaymentAct(
        id: id,
        user: user.toEntity(),
        date: date,
        sum: sum,
      );
}
