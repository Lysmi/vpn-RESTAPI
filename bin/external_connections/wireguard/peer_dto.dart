// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class PeerDTO {
  String publicKey;
  String urlSafePublicKey;
  String presharedKey;
  List<String> allowedIps;
  String lastHandshakeTime;
  String persistentKeepaliveInterval;
  String endpoint;
  int receiveBytes;
  int transmitBytes;
  PeerDTO({
    required this.publicKey,
    required this.urlSafePublicKey,
    required this.presharedKey,
    required this.allowedIps,
    required this.lastHandshakeTime,
    required this.persistentKeepaliveInterval,
    required this.endpoint,
    required this.receiveBytes,
    required this.transmitBytes,
  });

  PeerDTO copyWith({
    String? publicKey,
    String? urlSafePublicKey,
    String? presharedKey,
    List<String>? allowedIps,
    String? lastHandshakeTime,
    String? persistentKeepaliveInterval,
    String? endpoint,
    int? receiveBytes,
    int? transmitBytes,
  }) {
    return PeerDTO(
      publicKey: publicKey ?? this.publicKey,
      urlSafePublicKey: urlSafePublicKey ?? this.urlSafePublicKey,
      presharedKey: presharedKey ?? this.presharedKey,
      allowedIps: allowedIps ?? this.allowedIps,
      lastHandshakeTime: lastHandshakeTime ?? this.lastHandshakeTime,
      persistentKeepaliveInterval:
          persistentKeepaliveInterval ?? this.persistentKeepaliveInterval,
      endpoint: endpoint ?? this.endpoint,
      receiveBytes: receiveBytes ?? this.receiveBytes,
      transmitBytes: transmitBytes ?? this.transmitBytes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'publicKey': publicKey,
      'urlSafePublicKey': urlSafePublicKey,
      'presharedKey': presharedKey,
      'allowedIps': allowedIps,
      'lastHandshakeTime': lastHandshakeTime,
      'persistentKeepaliveInterval': persistentKeepaliveInterval,
      'endpoint': endpoint,
      'receiveBytes': receiveBytes,
      'transmitBytes': transmitBytes,
    };
  }

  factory PeerDTO.fromMap(Map<String, dynamic> map) {
    return PeerDTO(
      publicKey: map['publicKey'] as String,
      urlSafePublicKey: map['urlSafePublicKey'] as String,
      presharedKey: map['presharedKey'] as String,
      allowedIps: List<String>.from((map['allowedIps'] as List<String>)),
      lastHandshakeTime: map['lastHandshakeTime'] as String,
      persistentKeepaliveInterval: map['persistentKeepaliveInterval'] as String,
      endpoint: map['endpoint'] as String,
      receiveBytes: map['receiveBytes'] as int,
      transmitBytes: map['transmitBytes'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PeerDTO.fromJson(String source) =>
      PeerDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PeerDTO(publicKey: $publicKey, urlSafePublicKey: $urlSafePublicKey, presharedKey: $presharedKey, allowedIps: $allowedIps, lastHandshakeTime: $lastHandshakeTime, persistentKeepaliveInterval: $persistentKeepaliveInterval, endpoint: $endpoint, receiveBytes: $receiveBytes, transmitBytes: $transmitBytes)';
  }

  @override
  bool operator ==(covariant PeerDTO other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.publicKey == publicKey &&
        other.urlSafePublicKey == urlSafePublicKey &&
        other.presharedKey == presharedKey &&
        listEquals(other.allowedIps, allowedIps) &&
        other.lastHandshakeTime == lastHandshakeTime &&
        other.persistentKeepaliveInterval == persistentKeepaliveInterval &&
        other.endpoint == endpoint &&
        other.receiveBytes == receiveBytes &&
        other.transmitBytes == transmitBytes;
  }

  @override
  int get hashCode {
    return publicKey.hashCode ^
        urlSafePublicKey.hashCode ^
        presharedKey.hashCode ^
        allowedIps.hashCode ^
        lastHandshakeTime.hashCode ^
        persistentKeepaliveInterval.hashCode ^
        endpoint.hashCode ^
        receiveBytes.hashCode ^
        transmitBytes.hashCode;
  }
}
