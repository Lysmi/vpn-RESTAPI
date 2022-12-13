import 'user.dart';

class PaymentAct {
  int? id;
  User user;
  int sum;
  DateTime date;

  PaymentAct({
    this.id,
    required this.date,
    required this.sum,
    required this.user,
  });

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
