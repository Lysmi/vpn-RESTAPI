import 'sertificate.dart';

class User {
  int? id;
  String telegramId;
  String username;
  String firstName;
  String lastName;
  int balance;
  bool freePeriodUsed;
  Sertificate? currentCertificate;

  User({
    this.id,
    required this.telegramId,
    this.balance = 0,
    this.currentCertificate,
    this.firstName = '',
    this.freePeriodUsed = false,
    this.lastName = '',
    this.username = '',
  });

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
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      balance: balance ?? this.balance,
      freePeriodUsed: freePeriodUsed ?? this.freePeriodUsed,
      currentCertificate: currentCertificate ?? this.currentCertificate,
    );
  }
}
