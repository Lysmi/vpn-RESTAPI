import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../domain/usecases/events_usecases.dart';
import '../domain/usecases/get_user_usecase.dart';
import 'controller_interface.dart';
import 'package:http/http.dart' as http;

class EventController extends IController {
  EventController({required super.router});

  @override
  EventController addHandlers() {
    router
      ..post('/subscribeOn', _subscribeOn)
      ..get('/notifySubscribers/<userId>', _notifySubscribers)
      ..post('/testSubscribe', _testSubscribe)
      ..post('/sendMessages', _notify);
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

  // rassilki
  var host = "http://localhost:8085/send-message"; 

  // postData = {
  //    "users": [<ids>]
  //    "message": "message"
  // }
  Future<Response> _notify(Request req) async {
    var body = await req.readAsString();
    var postData = jsonDecode(body);

    var users = [];
    // check users on exist
    for (var userId in postData["usersIds"]) {
      users.add(await GetUserUsecase.getUserById(userId));
    }

    var responce = await http.post(Uri.parse(host), body: body);

    return Response.ok('Notified');
  }

}
