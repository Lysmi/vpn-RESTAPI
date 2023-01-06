// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class PeerDTO {
  String publicKey;
  String url_safe_public_key;
  String preshared_key;
  List<String> allowed_ips;
  String last_handshake_time;
  String persistent_keepalive_interval;
  String endpoint;
  int receive_bytes;
  int transmit_bytes;
  PeerDTO({
    required this.publicKey,
    required this.url_safe_public_key,
    required this.preshared_key,
    required this.allowed_ips,
    required this.last_handshake_time,
    required this.persistent_keepalive_interval,
    required this.endpoint,
    required this.receive_bytes,
    required this.transmit_bytes,
  });

  PeerDTO copyWith({
    String? publicKey,
    String? url_safe_public_key,
    String? preshared_key,
    List<String>? allowed_ips,
    String? last_handshake_time,
    String? persistent_keepalive_interval,
    String? endpoint,
    int? receive_bytes,
    int? transmit_bytes,
  }) {
    return PeerDTO(
      publicKey: publicKey ?? this.publicKey,
      url_safe_public_key: url_safe_public_key ?? this.url_safe_public_key,
      preshared_key: preshared_key ?? this.preshared_key,
      allowed_ips: allowed_ips ?? this.allowed_ips,
      last_handshake_time: last_handshake_time ?? this.last_handshake_time,
      persistent_keepalive_interval:
          persistent_keepalive_interval ?? this.persistent_keepalive_interval,
      endpoint: endpoint ?? this.endpoint,
      receive_bytes: receive_bytes ?? this.receive_bytes,
      transmit_bytes: transmit_bytes ?? this.transmit_bytes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'publicKey': publicKey,
      'url_safe_public_key': url_safe_public_key,
      'preshared_key': preshared_key,
      'allowed_ips': allowed_ips,
      'last_handshake_time': last_handshake_time,
      'persistent_keepalive_interval': persistent_keepalive_interval,
      'endpoint': endpoint,
      'receive_bytes': receive_bytes,
      'transmit_bytes': transmit_bytes,
    };
  }

  factory PeerDTO.fromMap(Map<String, dynamic> map) {
    return PeerDTO(
      publicKey: map['publicKey'] as String,
      url_safe_public_key: map['url_safe_public_key'] as String,
      preshared_key: map['preshared_key'] as String,
      allowed_ips: List<String>.from((map['allowed_ips'] as List<String>)),
      last_handshake_time: map['last_handshake_time'] as String,
      persistent_keepalive_interval:
          map['persistent_keepalive_interval'] as String,
      endpoint: map['endpoint'] as String,
      receive_bytes: map['receive_bytes'] as int,
      transmit_bytes: map['transmit_bytes'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PeerDTO.fromJson(String source) =>
      PeerDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PeerDTO(publicKey: $publicKey, url_safe_public_key: $url_safe_public_key, preshared_key: $preshared_key, allowed_ips: $allowed_ips, last_handshake_time: $last_handshake_time, persistent_keepalive_interval: $persistent_keepalive_interval, endpoint: $endpoint, receive_bytes: $receive_bytes, transmit_bytes: $transmit_bytes)';
  }

  @override
  bool operator ==(covariant PeerDTO other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.publicKey == publicKey &&
        other.url_safe_public_key == url_safe_public_key &&
        other.preshared_key == preshared_key &&
        listEquals(other.allowed_ips, allowed_ips) &&
        other.last_handshake_time == last_handshake_time &&
        other.persistent_keepalive_interval == persistent_keepalive_interval &&
        other.endpoint == endpoint &&
        other.receive_bytes == receive_bytes &&
        other.transmit_bytes == transmit_bytes;
  }

  @override
  int get hashCode {
    return publicKey.hashCode ^
        url_safe_public_key.hashCode ^
        preshared_key.hashCode ^
        allowed_ips.hashCode ^
        last_handshake_time.hashCode ^
        persistent_keepalive_interval.hashCode ^
        endpoint.hashCode ^
        receive_bytes.hashCode ^
        transmit_bytes.hashCode;
  }
}
