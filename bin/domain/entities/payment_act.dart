// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
    required this.user,
    required this.sum,
    required this.date,
  }) : id = id ?? Uuid().v4();

  PaymentAct copyWith({
    String? id,
    User? user,
    int? sum,
    DateTime? date,
  }) {
    return PaymentAct(
      id: id ?? this.id,
      user: user ?? this.user,
      sum: sum ?? this.sum,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user.toMap(),
      'sum': sum,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory PaymentAct.fromMap(Map<String, dynamic> map) {
    return PaymentAct(
      id: map['id'] as String,
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      sum: map['sum'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentAct.fromJson(String source) =>
      PaymentAct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentAct(id: $id, user: $user, sum: $sum, date: $date)';
  }

  @override
  bool operator ==(covariant PaymentAct other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user == user &&
        other.sum == sum &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ user.hashCode ^ sum.hashCode ^ date.hashCode;
  }
}
