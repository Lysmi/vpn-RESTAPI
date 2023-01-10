// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:uuid/uuid.dart';

import 'server.dart';

@jsonSerializable
class Sertificate {
  String id;
  String publicKey;
  Server server;
  DateTime dateCreate;

  Sertificate({
    id,
    required this.publicKey,
    required this.server,
    required this.dateCreate,
  }) : id = id ?? Uuid().v4();

  Sertificate copyWith({
    String? id,
    String? privateKey,
    String? publicKey,
    Server? server,
    DateTime? dateCreate,
  }) {
    return Sertificate(
      id: id ?? this.id,
      publicKey: publicKey ?? this.publicKey,
      server: server ?? this.server,
      dateCreate: dateCreate ?? this.dateCreate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'publicKey': publicKey,
      'server': server.toMap(),
      'dateCreate': dateCreate.millisecondsSinceEpoch,
    };
  }

  factory Sertificate.fromMap(Map<String, dynamic> map) {
    return Sertificate(
      id: map['id'] as String,
      publicKey: map['publicKey'] as String,
      server: Server.fromMap(map['server'] as Map<String, dynamic>),
      dateCreate: DateTime.fromMillisecondsSinceEpoch(map['dateCreate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Sertificate.fromJson(String source) =>
      Sertificate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Sertificate(id: $id, publicKey: $publicKey, server: $server, dateCreate: $dateCreate)';
  }

  @override
  bool operator ==(covariant Sertificate other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.publicKey == publicKey &&
        other.server == server &&
        other.dateCreate == dateCreate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        publicKey.hashCode ^
        server.hashCode ^
        dateCreate.hashCode;
  }
}
