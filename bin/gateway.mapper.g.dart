// This file has been generated by the dart_json_mapper v2.2.5+1
// https://github.com/k-paxian/dart-json-mapper
// @dart = 2.12
import 'domain/entities/region.dart' as x1 show Region;
import 'domain/entities/sertificate.dart' as x2 show Sertificate;
import 'domain/entities/server.dart' as x3 show Server;
import 'domain/entities/user.dart' as x0 show User;
import 'package:dart_json_mapper/dart_json_mapper.dart' show JsonMapper, JsonMapperAdapter, typeOf;
// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.


import 'dart:core';
import 'domain/entities/region.dart' as prefix1;
import 'domain/entities/sertificate.dart' as prefix4;
import 'domain/entities/server.dart' as prefix2;
import 'domain/entities/user.dart' as prefix3;
import 'package:dart_json_mapper/src/model/annotations.dart' as prefix0;

// ignore_for_file: camel_case_types
// ignore_for_file: implementation_imports
// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const

// ignore:unused_import
import 'package:reflectable/mirrors.dart' as m;
// ignore:unused_import
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
// ignore:unused_import
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{const prefix0.JsonSerializable(): r.ReflectorData(<m.TypeMirror>[r.NonGenericClassMirrorImpl(r'Region', r'.Region', 134217735, 0, const prefix0.JsonSerializable(), const <int>[0, 1, 17, 18, 19, 20, 21, 22, 27, 28, 29, 30], const <int>[22, 21, 31, 27, 32, 17, 18, 19, 20, 23, 24, 25, 26], const <int>[], -1, {}, {}, {r'': (bool b) => ({id, regionName}) => b ? prefix1.Region(id: id, regionName: regionName) : null, r'fromMap': (bool b) => (map) => b ? prefix1.Region.fromMap(map) : null, r'fromJson': (bool b) => (source) => b ? prefix1.Region.fromJson(source) : null}, -1, 0, const <int>[], const [prefix0.jsonSerializable], null), r.NonGenericClassMirrorImpl(r'Server', r'.Server', 134217735, 1, const prefix0.JsonSerializable(), const <int>[2, 3, 4, 5, 6, 33, 34, 35, 36, 37, 48, 49, 50, 51], const <int>[37, 36, 31, 48, 32, 33, 34, 35, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47], const <int>[], -1, {}, {}, {r'': (bool b) => ({id, ip, serverName, countUsers, region}) => b ? prefix2.Server(id: id, countUsers: countUsers, ip: ip, region: region, serverName: serverName) : null, r'fromMap': (bool b) => (map) => b ? prefix2.Server.fromMap(map) : null, r'fromJson': (bool b) => (source) => b ? prefix2.Server.fromJson(source) : null}, -1, 1, const <int>[], const [prefix0.jsonSerializable], null), r.NonGenericClassMirrorImpl(r'User', r'.User', 134217735, 2, const prefix0.JsonSerializable(), const <int>[7, 8, 9, 10, 11, 12, 52, 53, 54, 55, 56, 69, 70, 71, 72], const <int>[56, 55, 31, 69, 32, 52, 53, 54, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68], const <int>[], -1, {}, {}, {r'': (bool b) => ({id, username = '', balance = 0, freePeriodUsed = false, region, currentCertificate}) => b ? prefix3.User(balance: balance, currentCertificate: currentCertificate, freePeriodUsed: freePeriodUsed, username: username, id: id, region: region) : null, r'fromMap': (bool b) => (map) => b ? prefix3.User.fromMap(map) : null, r'fromJson': (bool b) => (source) => b ? prefix3.User.fromJson(source) : null}, -1, 2, const <int>[], const [prefix0.jsonSerializable], null), r.NonGenericClassMirrorImpl(r'Sertificate', r'.Sertificate', 134217735, 3, const prefix0.JsonSerializable(), const <int>[13, 14, 15, 16, 73, 74, 75, 76, 77, 86, 87, 88, 89], const <int>[77, 76, 31, 86, 32, 73, 74, 75, 78, 79, 80, 81, 82, 83, 84, 85], const <int>[], -1, {}, {}, {r'': (bool b) => ({id, publicKey, server, dateCreate}) => b ? prefix4.Sertificate(id: id, dateCreate: dateCreate, publicKey: publicKey, server: server) : null, r'fromMap': (bool b) => (map) => b ? prefix4.Sertificate.fromMap(map) : null, r'fromJson': (bool b) => (source) => b ? prefix4.Sertificate.fromJson(source) : null}, -1, 3, const <int>[], const [prefix0.jsonSerializable], null)], <m.DeclarationMirror>[r.VariableMirrorImpl(r'id', 134348805, 0, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const []), r.VariableMirrorImpl(r'regionName', 134348805, 0, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const []), r.VariableMirrorImpl(r'id', 134348805, 1, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const []), r.VariableMirrorImpl(r'ip', 134348805, 1, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const []), r.VariableMirrorImpl(r'serverName', 134348805, 1, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const []), r.VariableMirrorImpl(r'countUsers', 134348805, 1, const prefix0.JsonSerializable(), -1, 5, 5, const <int>[], const []), r.VariableMirrorImpl(r'region', 134348805, 1, const prefix0.JsonSerializable(), 0, 0, 0, const <int>[], const []), r.VariableMirrorImpl(r'id', 134348805, 2, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const []), r.VariableMirrorImpl(r'username', 134348805, 2, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const []), r.VariableMirrorImpl(r'balance', 134348805, 2, const prefix0.JsonSerializable(), -1, 5, 5, const <int>[], const []), r.VariableMirrorImpl(r'freePeriodUsed', 134348805, 2, const prefix0.JsonSerializable(), -1, 6, 6, const <int>[], const []), r.VariableMirrorImpl(r'region', 67239941, 2, const prefix0.JsonSerializable(), 0, 0, 0, const <int>[], const []), r.VariableMirrorImpl(r'currentCertificate', 67239941, 2, const prefix0.JsonSerializable(), 3, 3, 3, const <int>[], const []), r.VariableMirrorImpl(r'id', 134348805, 3, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const []), r.VariableMirrorImpl(r'publicKey', 134348805, 3, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const []), r.VariableMirrorImpl(r'server', 134348805, 3, const prefix0.JsonSerializable(), 1, 1, 1, const <int>[], const []), r.VariableMirrorImpl(r'dateCreate', 134348805, 3, const prefix0.JsonSerializable(), -1, 7, 7, const <int>[], const []), r.MethodMirrorImpl(r'copyWidth', 2097154, 0, 0, 0, 0, const <int>[], const <int>[0, 1], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'copyWith', 2097154, 0, 0, 0, 0, const <int>[], const <int>[2, 3], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'toMap', 35651586, 0, -1, 8, 9, null, const <int>[], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'toJson', 2097154, 0, -1, 4, 4, const <int>[], const <int>[], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'toString', 2097154, 0, -1, 4, 4, const <int>[], const <int>[], const prefix0.JsonSerializable(), const [override]), r.MethodMirrorImpl(r'==', 2097154, 0, -1, 6, 6, const <int>[], const <int>[4], const prefix0.JsonSerializable(), const [override]), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 0, 23), r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 0, 24), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 1, 25), r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 1, 26), r.MethodMirrorImpl(r'hashCode', 2097155, 0, -1, 5, 5, const <int>[], const <int>[], const prefix0.JsonSerializable(), const [override]), r.MethodMirrorImpl(r'', 0, 0, -1, 0, 0, const <int>[], const <int>[5, 6], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'fromMap', 1, 0, -1, 0, 0, const <int>[], const <int>[7], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'fromJson', 1, 0, -1, 0, 0, const <int>[], const <int>[8], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'noSuchMethod', 524290, -1, -1, -1, -1, const <int>[], const <int>[11], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'runtimeType', 2097155, -1, -1, 10, 10, const <int>[], const <int>[], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'copyWith', 2097154, 1, 1, 1, 1, const <int>[], const <int>[12, 13, 14, 15, 16], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'toMap', 35651586, 1, -1, 8, 9, null, const <int>[], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'toJson', 2097154, 1, -1, 4, 4, const <int>[], const <int>[], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'toString', 2097154, 1, -1, 4, 4, const <int>[], const <int>[], const prefix0.JsonSerializable(), const [override]), r.MethodMirrorImpl(r'==', 2097154, 1, -1, 6, 6, const <int>[], const <int>[17], const prefix0.JsonSerializable(), const [override]), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 2, 38), r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 2, 39), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 3, 40), r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 3, 41), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 4, 42), r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 4, 43), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 5, 44), r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 5, 45), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 6, 46), r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 6, 47), r.MethodMirrorImpl(r'hashCode', 2097155, 1, -1, 5, 5, const <int>[], const <int>[], const prefix0.JsonSerializable(), const [override]), r.MethodMirrorImpl(r'', 0, 1, -1, 1, 1, const <int>[], const <int>[18, 19, 20, 21, 22], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'fromMap', 1, 1, -1, 1, 1, const <int>[], const <int>[23], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'fromJson', 1, 1, -1, 1, 1, const <int>[], const <int>[24], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'copyWith', 2097154, 2, 2, 2, 2, const <int>[], const <int>[30, 31, 32, 33, 34, 35], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'toMap', 35651586, 2, -1, 8, 9, null, const <int>[], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'toJson', 2097154, 2, -1, 4, 4, const <int>[], const <int>[], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'toString', 2097154, 2, -1, 4, 4, const <int>[], const <int>[], const prefix0.JsonSerializable(), const [override]), r.MethodMirrorImpl(r'==', 2097154, 2, -1, 6, 6, const <int>[], const <int>[36], const prefix0.JsonSerializable(), const [override]), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 7, 57), r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 7, 58), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 8, 59), r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 8, 60), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 9, 61), r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 9, 62), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 10, 63), r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 10, 64), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 11, 65), r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 11, 66), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 12, 67), r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 12, 68), r.MethodMirrorImpl(r'hashCode', 2097155, 2, -1, 5, 5, const <int>[], const <int>[], const prefix0.JsonSerializable(), const [override]), r.MethodMirrorImpl(r'', 0, 2, -1, 2, 2, const <int>[], const <int>[37, 38, 39, 40, 41, 42], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'fromMap', 1, 2, -1, 2, 2, const <int>[], const <int>[43], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'fromJson', 1, 2, -1, 2, 2, const <int>[], const <int>[44], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'copyWith', 2097154, 3, 3, 3, 3, const <int>[], const <int>[51, 52, 53, 54, 55], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'toMap', 35651586, 3, -1, 8, 9, null, const <int>[], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'toJson', 2097154, 3, -1, 4, 4, const <int>[], const <int>[], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'toString', 2097154, 3, -1, 4, 4, const <int>[], const <int>[], const prefix0.JsonSerializable(), const [override]), r.MethodMirrorImpl(r'==', 2097154, 3, -1, 6, 6, const <int>[], const <int>[56], const prefix0.JsonSerializable(), const [override]), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 13, 78), r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 13, 79), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 14, 80), r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 14, 81), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 15, 82), r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 15, 83), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 16, 84), r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 16, 85), r.MethodMirrorImpl(r'hashCode', 2097155, 3, -1, 5, 5, const <int>[], const <int>[], const prefix0.JsonSerializable(), const [override]), r.MethodMirrorImpl(r'', 0, 3, -1, 3, 3, const <int>[], const <int>[57, 58, 59, 60], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'fromMap', 1, 3, -1, 3, 3, const <int>[], const <int>[61], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'fromJson', 1, 3, -1, 3, 3, const <int>[], const <int>[62], const prefix0.JsonSerializable(), const [])], <m.ParameterMirror>[r.ParameterMirrorImpl(r'id', 67153926, 17, const prefix0.JsonSerializable(), -1, -1, -1, const <int>[], const [], null, #id), r.ParameterMirrorImpl(r'regionName', 67153926, 17, const prefix0.JsonSerializable(), -1, -1, -1, const <int>[], const [], null, #regionName), r.ParameterMirrorImpl(r'id', 67252230, 18, const prefix0.JsonSerializable(), -1, 11, 11, const <int>[], const [], null, #id), r.ParameterMirrorImpl(r'regionName', 67252230, 18, const prefix0.JsonSerializable(), -1, 11, 11, const <int>[], const [], null, #regionName), r.ParameterMirrorImpl(r'other', 134348806, 22, const prefix0.JsonSerializable(), 0, 0, 0, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'id', 67153926, 28, const prefix0.JsonSerializable(), -1, -1, -1, const <int>[], const [], null, #id), r.ParameterMirrorImpl(r'regionName', 134358022, 28, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, #regionName), r.ParameterMirrorImpl(r'map', 151126022, 29, const prefix0.JsonSerializable(), -1, 8, 9, null, const [], null, null), r.ParameterMirrorImpl(r'source', 134348806, 30, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'_id', 134348902, 24, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'_regionName', 134348902, 26, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'invocation', 134348806, 31, const prefix0.JsonSerializable(), -1, 12, 12, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'id', 67252230, 33, const prefix0.JsonSerializable(), -1, 11, 11, const <int>[], const [], null, #id), r.ParameterMirrorImpl(r'ip', 67252230, 33, const prefix0.JsonSerializable(), -1, 11, 11, const <int>[], const [], null, #ip), r.ParameterMirrorImpl(r'serverName', 67252230, 33, const prefix0.JsonSerializable(), -1, 11, 11, const <int>[], const [], null, #serverName), r.ParameterMirrorImpl(r'countUsers', 67252230, 33, const prefix0.JsonSerializable(), -1, 13, 13, const <int>[], const [], null, #countUsers), r.ParameterMirrorImpl(r'region', 67252230, 33, const prefix0.JsonSerializable(), 0, 0, 0, const <int>[], const [], null, #region), r.ParameterMirrorImpl(r'other', 134348806, 37, const prefix0.JsonSerializable(), 1, 1, 1, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'id', 67153926, 49, const prefix0.JsonSerializable(), -1, -1, -1, const <int>[], const [], null, #id), r.ParameterMirrorImpl(r'ip', 134358022, 49, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, #ip), r.ParameterMirrorImpl(r'serverName', 134358022, 49, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, #serverName), r.ParameterMirrorImpl(r'countUsers', 134358022, 49, const prefix0.JsonSerializable(), -1, 5, 5, const <int>[], const [], null, #countUsers), r.ParameterMirrorImpl(r'region', 134358022, 49, const prefix0.JsonSerializable(), 0, 0, 0, const <int>[], const [], null, #region), r.ParameterMirrorImpl(r'map', 151126022, 50, const prefix0.JsonSerializable(), -1, 8, 9, null, const [], null, null), r.ParameterMirrorImpl(r'source', 134348806, 51, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'_id', 134348902, 39, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'_ip', 134348902, 41, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'_serverName', 134348902, 43, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'_countUsers', 134348902, 45, const prefix0.JsonSerializable(), -1, 5, 5, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'_region', 134348902, 47, const prefix0.JsonSerializable(), 0, 0, 0, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'id', 67252230, 52, const prefix0.JsonSerializable(), -1, 11, 11, const <int>[], const [], null, #id), r.ParameterMirrorImpl(r'username', 67252230, 52, const prefix0.JsonSerializable(), -1, 11, 11, const <int>[], const [], null, #username), r.ParameterMirrorImpl(r'balance', 67252230, 52, const prefix0.JsonSerializable(), -1, 13, 13, const <int>[], const [], null, #balance), r.ParameterMirrorImpl(r'freePeriodUsed', 67252230, 52, const prefix0.JsonSerializable(), -1, 14, 14, const <int>[], const [], null, #freePeriodUsed), r.ParameterMirrorImpl(r'region', 67252230, 52, const prefix0.JsonSerializable(), 0, 0, 0, const <int>[], const [], null, #region), r.ParameterMirrorImpl(r'currentCertificate', 67252230, 52, const prefix0.JsonSerializable(), 3, 3, 3, const <int>[], const [], null, #currentCertificate), r.ParameterMirrorImpl(r'other', 134348806, 56, const prefix0.JsonSerializable(), 2, 2, 2, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'id', 134358022, 70, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, #id), r.ParameterMirrorImpl(r'username', 134364166, 70, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], '', #username), r.ParameterMirrorImpl(r'balance', 134364166, 70, const prefix0.JsonSerializable(), -1, 5, 5, const <int>[], const [], 0, #balance), r.ParameterMirrorImpl(r'freePeriodUsed', 134364166, 70, const prefix0.JsonSerializable(), -1, 6, 6, const <int>[], const [], false, #freePeriodUsed), r.ParameterMirrorImpl(r'region', 67249158, 70, const prefix0.JsonSerializable(), 0, 0, 0, const <int>[], const [], null, #region), r.ParameterMirrorImpl(r'currentCertificate', 67253254, 70, const prefix0.JsonSerializable(), 3, 3, 3, const <int>[], const [], null, #currentCertificate), r.ParameterMirrorImpl(r'map', 151126022, 71, const prefix0.JsonSerializable(), -1, 8, 9, null, const [], null, null), r.ParameterMirrorImpl(r'source', 134348806, 72, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'_id', 134348902, 58, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'_username', 134348902, 60, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'_balance', 134348902, 62, const prefix0.JsonSerializable(), -1, 5, 5, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'_freePeriodUsed', 134348902, 64, const prefix0.JsonSerializable(), -1, 6, 6, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'_region', 67240038, 66, const prefix0.JsonSerializable(), 0, 0, 0, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'_currentCertificate', 67240038, 68, const prefix0.JsonSerializable(), 3, 3, 3, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'id', 67252230, 73, const prefix0.JsonSerializable(), -1, 11, 11, const <int>[], const [], null, #id), r.ParameterMirrorImpl(r'privateKey', 67252230, 73, const prefix0.JsonSerializable(), -1, 11, 11, const <int>[], const [], null, #privateKey), r.ParameterMirrorImpl(r'publicKey', 67252230, 73, const prefix0.JsonSerializable(), -1, 11, 11, const <int>[], const [], null, #publicKey), r.ParameterMirrorImpl(r'server', 67252230, 73, const prefix0.JsonSerializable(), 1, 1, 1, const <int>[], const [], null, #server), r.ParameterMirrorImpl(r'dateCreate', 67252230, 73, const prefix0.JsonSerializable(), -1, 15, 15, const <int>[], const [], null, #dateCreate), r.ParameterMirrorImpl(r'other', 134348806, 77, const prefix0.JsonSerializable(), 3, 3, 3, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'id', 67153926, 87, const prefix0.JsonSerializable(), -1, -1, -1, const <int>[], const [], null, #id), r.ParameterMirrorImpl(r'publicKey', 134358022, 87, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, #publicKey), r.ParameterMirrorImpl(r'server', 134358022, 87, const prefix0.JsonSerializable(), 1, 1, 1, const <int>[], const [], null, #server), r.ParameterMirrorImpl(r'dateCreate', 134358022, 87, const prefix0.JsonSerializable(), -1, 7, 7, const <int>[], const [], null, #dateCreate), r.ParameterMirrorImpl(r'map', 151126022, 88, const prefix0.JsonSerializable(), -1, 8, 9, null, const [], null, null), r.ParameterMirrorImpl(r'source', 134348806, 89, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'_id', 134348902, 79, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'_publicKey', 134348902, 81, const prefix0.JsonSerializable(), -1, 4, 4, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'_server', 134348902, 83, const prefix0.JsonSerializable(), 1, 1, 1, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'_dateCreate', 134348902, 85, const prefix0.JsonSerializable(), -1, 7, 7, const <int>[], const [], null, null)], <Type>[prefix1.Region, prefix2.Server, prefix3.User, prefix4.Sertificate, String, int, bool, DateTime, const m.TypeValue<Map<String, dynamic>>().type, Map, Type, String, Invocation, int, bool, DateTime], 4, {r'==': (dynamic instance) => (x) => instance == x, r'toString': (dynamic instance) => instance.toString, r'noSuchMethod': (dynamic instance) => instance.noSuchMethod, r'hashCode': (dynamic instance) => instance.hashCode, r'runtimeType': (dynamic instance) => instance.runtimeType, r'copyWidth': (dynamic instance) => instance.copyWidth, r'copyWith': (dynamic instance) => instance.copyWith, r'toMap': (dynamic instance) => instance.toMap, r'toJson': (dynamic instance) => instance.toJson, r'id': (dynamic instance) => instance.id, r'regionName': (dynamic instance) => instance.regionName, r'ip': (dynamic instance) => instance.ip, r'serverName': (dynamic instance) => instance.serverName, r'countUsers': (dynamic instance) => instance.countUsers, r'region': (dynamic instance) => instance.region, r'username': (dynamic instance) => instance.username, r'balance': (dynamic instance) => instance.balance, r'freePeriodUsed': (dynamic instance) => instance.freePeriodUsed, r'currentCertificate': (dynamic instance) => instance.currentCertificate, r'publicKey': (dynamic instance) => instance.publicKey, r'server': (dynamic instance) => instance.server, r'dateCreate': (dynamic instance) => instance.dateCreate}, {r'id=': (dynamic instance, value) => instance.id = value, r'regionName=': (dynamic instance, value) => instance.regionName = value, r'ip=': (dynamic instance, value) => instance.ip = value, r'serverName=': (dynamic instance, value) => instance.serverName = value, r'countUsers=': (dynamic instance, value) => instance.countUsers = value, r'region=': (dynamic instance, value) => instance.region = value, r'username=': (dynamic instance, value) => instance.username = value, r'balance=': (dynamic instance, value) => instance.balance = value, r'freePeriodUsed=': (dynamic instance, value) => instance.freePeriodUsed = value, r'currentCertificate=': (dynamic instance, value) => instance.currentCertificate = value, r'publicKey=': (dynamic instance, value) => instance.publicKey = value, r'server=': (dynamic instance, value) => instance.server = value, r'dateCreate=': (dynamic instance, value) => instance.dateCreate = value}, null, [])};


final _memberSymbolMap = null;

void _initializeReflectable(JsonMapperAdapter adapter) {
  if (!adapter.isGenerated) {
    return;
  }
  r.data = adapter.reflectableData!;
  r.memberSymbolMap = adapter.memberSymbolMap;
}

final gatewayGeneratedAdapter = JsonMapperAdapter(
  title: 'vpn_rest_server',
  url: 'asset:vpn_rest_server/bin/gateway.dart',
  reflectableData: _data,
  memberSymbolMap: _memberSymbolMap,
  valueDecorators: {
    typeOf<List<x0.User>>(): (value) => value.cast<x0.User>(),
    typeOf<Set<x0.User>>(): (value) => value.cast<x0.User>(),
    typeOf<List<x1.Region>>(): (value) => value.cast<x1.Region>(),
    typeOf<Set<x1.Region>>(): (value) => value.cast<x1.Region>(),
    typeOf<List<x2.Sertificate>>(): (value) => value.cast<x2.Sertificate>(),
    typeOf<Set<x2.Sertificate>>(): (value) => value.cast<x2.Sertificate>(),
    typeOf<List<x3.Server>>(): (value) => value.cast<x3.Server>(),
    typeOf<Set<x3.Server>>(): (value) => value.cast<x3.Server>()
},
  enumValues: {

});

Future<JsonMapper> initializeJsonMapperAsync({Iterable<JsonMapperAdapter> adapters = const []}) => Future(() => initializeJsonMapper(adapters: adapters));

JsonMapper initializeJsonMapper({Iterable<JsonMapperAdapter> adapters = const []}) {
  JsonMapper.enumerateAdapters([...adapters, gatewayGeneratedAdapter], (JsonMapperAdapter adapter) {
    _initializeReflectable(adapter);
    JsonMapper().useAdapter(adapter);
  });
  return JsonMapper();
}