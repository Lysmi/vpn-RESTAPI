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
      ..get('/notifySubscribers/<userId>', _notifySubscribers)
      ..post('/testSubscribe', _testSubscribe);
    return this;
  }

  // postData = {
  //   "ip": "0.0.0.0",
  //   "userId": "727272",
  // }
  Future<Response> _subscribeOn(Request req) async {
    var body = await req.readAsString();
    var postData = jsonDecode(body);
    print("subscribers data: $postData");
    EventsUsecases.addBalanceNotifyReceiver(
      userId: postData["userId"],
      ip: postData["ip"],
    );
    return Response.ok('Subscribed');
  }

  Future<Response> _notifySubscribers(Request req, String id) async {
    print("start notify");
    EventsUsecases.notifySubscribers(id);
    return Response.ok('Notified');
  }

  Future<Response> _testSubscribe(Request req) async {
    var body = await req.readAsString();
    var postData = jsonDecode(body);
    print(postData);
    return Response.ok('Notified');
  }
}
