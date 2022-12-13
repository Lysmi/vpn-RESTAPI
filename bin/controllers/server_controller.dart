import 'package:shelf/shelf.dart';

import 'IController.dart';

class ServerController extends IController {
  ServerController({required super.router});

  @override
  ServerController addHandlers() {
    // TODO: implement addHandlers
    router
      ..get('/servers', _getAllServers)
      ..post('/servers', _postAddServer)
      ..patch('/servers', _patchServer)
      ..get('/servers/<serverId>', _getServerById);
    return this;
  }

  Response _getAllServers(Request req) {
    //TODO: implement
    return Response.ok('Unimplement');
  }

  Response _postAddServer(Request req) {
    //TODO: implement
    return Response.ok('Unimplement');
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
