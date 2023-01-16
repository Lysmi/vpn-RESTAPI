// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

abstract class Event {
  Future<void> sendOut();
}
