// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
    this.username = '',
    this.balance = 0,
    this.freePeriodUsed = false,
    this.currentCertificate,
  }) : id = id ?? Uuid().v4();

  User copyWith({
    String? id,
    String? telegramId,
    String? username,
    int? balance,
    bool? freePeriodUsed,
    Sertificate? currentCertificate,
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'telegramId': telegramId,
      'username': username,
      'balance': balance,
      'freePeriodUsed': freePeriodUsed,
      'currentCertificate': currentCertificate?.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      telegramId: map['telegramId'] as String,
      username: map['username'] as String,
      balance: map['balance'] as int,
      freePeriodUsed: map['freePeriodUsed'] as bool,
      currentCertificate: map['currentCertificate'] != null
          ? Sertificate.fromMap(
              map['currentCertificate'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, telegramId: $telegramId, username: $username, balance: $balance, freePeriodUsed: $freePeriodUsed, currentCertificate: $currentCertificate)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.telegramId == telegramId &&
        other.username == username &&
        other.balance == balance &&
        other.freePeriodUsed == freePeriodUsed &&
        other.currentCertificate == currentCertificate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        telegramId.hashCode ^
        username.hashCode ^
        balance.hashCode ^
        freePeriodUsed.hashCode ^
        currentCertificate.hashCode;
  }
}
