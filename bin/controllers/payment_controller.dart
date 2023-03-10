import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:http/http.dart' as http;

import 'controller_interface.dart';

class EventController extends IController {
  EventController({required super.router});

  @override
  EventController addHandlers() {
    router
      ..post('/balance-increse-notify', _balanceNotify);
    return this;
  }

  Future<Response> _balanceNotify(Request req) async {
    // TODO
    return Response.ok("ok");
  }

  Future<Response> _createPayInIoCassa(Request req) async {
    // TODO
    return Response.ok("ok");
  }
}
