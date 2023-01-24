import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:shelf/shelf.dart';

import '../domain/entities/region.dart';
import '../domain/usecases/server_usecase.dart';
import 'controller_interface.dart';

class RegionController extends IController {
  RegionController({required super.router});

  @override
  RegionController addHandlers() {
    router
      ..post('/regions', _addRegion)
      ..get('/regions', _getRegions);
    return this;
  }

  // postData = {
  //   "name": 'ru'
  // }
  Future<Response> _addRegion(Request req) async {
    var body = await req.readAsString();
    var postData = jsonDecode(body);
    ServerUsecase.addRegion(Region(regionName: postData['name']));
    return Response.ok('Created');
  }

  Future<Response> _getRegions(Request req) async {
    var regions = await ServerUsecase.getRegions();
    return Response.ok(JsonMapper.serialize(regions));
  }
}
