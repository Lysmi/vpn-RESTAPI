import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:uuid/uuid.dart';

import 'sertificate.dart';

@jsonSerializable
class User {
  String id;
  String telegramId;
  String username;
  int balance;
  bool freePeriodUsed;
  Sertificate? currentCertificate;

  User({
    id,
    required this.telegramId,
    this.balance = 0,
    this.currentCertificate,
    this.freePeriodUsed = false,
    this.username = '',
  }) : id = id ?? Uuid().v4();

  User copyWith({
    int? id,
    String? telegramId,
    int? balance,
    Sertificate? currentCertificate,
    String? firstName,
    bool? freePeriodUsed,
    String? lastName,
    String? username,
  }) {
    return User(
      id: id ?? this.id,
      telegramId: telegramId ?? this.telegramId,
      username: username ?? this.username,
      balance: balance ?? this.balance,
      freePeriodUsed: freePeriodUsed ?? this.freePeriodUsed,
      currentCertificate: currentCertificate ?? this.currentCertificate,
    );
  }
}
