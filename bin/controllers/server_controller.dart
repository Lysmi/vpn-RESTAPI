import 'package:shelf/shelf.dart';

import 'controller_interface.dart';

class ServerController extends IController {
  ServerController({required super.router});
  
  final _url = '/api/server';

  @override
  ServerController addHandlers() {
    router
      ..get(_url, _getAllServers)
      ..post(_url, _postAddServer)
      ..patch(_url, _patchServer)
      ..get('$_url/<serverId>', _getServerById);
    
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
