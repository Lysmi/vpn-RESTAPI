import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:uuid/uuid.dart';

import 'user.dart';

@jsonSerializable
class PaymentAct {
  String id;
  User user;
  int sum;
  DateTime date;

  PaymentAct({
    id,
    required this.date,
    required this.sum,
    required this.user,
  }) : id = id ?? Uuid().v4();

  PaymentAct copyWith({
    id,
    date,
    sum,
    user,
  }) {
    return PaymentAct(
      id: id ?? this.id,
      date: date ?? this.date,
      sum: sum ?? this.sum,
      user: user ?? this.user,
    );
  }
}
