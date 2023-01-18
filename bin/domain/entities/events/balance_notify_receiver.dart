// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import
import 'dart:convert';

import 'dart:collection';
import 'package:http/http.dart' as http;

import '../user.dart' as entities;
import 'event.dart';

class BalanceNotifyReceiver implements Event {
  final String ip;
  final entities.User user;

  BalanceNotifyReceiver({
    required this.ip,
    required this.user,
  });

  @override
  Future<void> sendOut() async {
    http.post(Uri.parse(ip),
        body: jsonEncode({"Event": "balanceNotify", "User": user.toJson()}));
  }

  BalanceNotifyReceiver copyWith({
    String? ip,
    entities.User? user,
  }) {
    return BalanceNotifyReceiver(
      ip: ip ?? this.ip,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ip': ip,
      'user': user.toMap(),
    };
  }

  factory BalanceNotifyReceiver.fromMap(Map<String, dynamic> map) {
    return BalanceNotifyReceiver(
      ip: map['ip'] as String,
      user: entities.User.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory BalanceNotifyReceiver.fromJson(String source) =>
      BalanceNotifyReceiver.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BalanceNotifyReceiver(ip: $ip, user: $user)';

  @override
  bool operator ==(covariant BalanceNotifyReceiver other) {
    if (identical(this, other)) return true;

    return other.ip == ip && other.user == user;
  }

  @override
  int get hashCode => ip.hashCode ^ user.hashCode;
}
