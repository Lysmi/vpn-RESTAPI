import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';

import '../domain/usecases/events_usecases.dart';
import '../domain/usecases/server_usecase.dart';
import 'controller_interface.dart';
import '../domain/entities/events/balanceNotifyReceiver.dart' as entities;

class EventController extends IController {
  EventController({required super.router});

  @override
  EventController addHandlers() {
    router
      ..post('/subscribeOn', _subscribeOn)
      ..get('/notifySubscribers/<userId>', _notifySubscribers);
    return this;
  }

  // postData = {
  //   "ip": "0.0.0.0",
  //   "userId": "727272",
  // }
  Future<Response> _subscribeOn(Request req) async {
    final eventsUsecases = GetIt.I<EventsUsecases>();
    var body = await req.readAsString();
    var postData = jsonDecode(body);

    eventsUsecases.addBalanceNotifyReceiver(postData["ip"], postData["userId"]);

    return Response.ok('Subscribed');
  }

  Future<Response> _notifySubscribers(Request req, String id) async {
    final eventsUsecases = GetIt.I<EventsUsecases>();
    eventsUsecases.notifySubscribers(id);
    return Response.ok('Notified');
  }
}
