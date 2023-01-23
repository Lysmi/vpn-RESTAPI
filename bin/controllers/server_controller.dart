import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:shelf/shelf.dart';

import '../domain/entities/region.dart';
import '../domain/entities/server.dart' as entity;
import '../domain/usecases/server_usecase.dart';
import 'controller_interface.dart';

class ServerController extends IController {
  ServerController({required super.router});

  @override
  ServerController addHandlers() {
    router
      ..get('/servers', _getAllServers)
      ..post('/servers', _postAddServer)
      ..patch('/servers', _patchServer)
      ..get('/servers/<serverId>', _getServerById);
    return this;
  }

  Future<Response> _getAllServers(Request req) async {
    var servers = await ServerUsecase.getServers();
    return Response.ok(JsonMapper.serialize(servers));
  }

  // postData = {
  //   "ip": "0.0.0.0",
  //   "serverName": "lysmiServer",
  // }
  Future<Response> _postAddServer(Request req) async {
    var body = await req.readAsString();
    var postData = jsonDecode(body);

    ServerUsecase.addServer(entity.Server(
        ip: postData["ip"],
        serverName: postData["serverName"],
        countUsers: 0,
        region: Region(regionName: 'ru')));

    return Response.ok('Created');
  }

  Response _patchServer(Request req) {
    //TODO: implement
    return Response.ok('Unimplement');
  }

  Response _getServerById(Request req, int id) {
    //TODO: implement
    return Response.ok('Unimplement');
  }
}
