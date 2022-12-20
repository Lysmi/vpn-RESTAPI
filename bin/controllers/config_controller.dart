import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:http_parser/http_parser.dart';

import 'controller_interface.dart';

class ConfigController extends IController {
  ConfigController({required super.router});

  final _url = '/api/config';

  @override
  ConfigController addHandlers() {
    router.get('$_url/swagger.yaml', _getSwaggerYaml);
    return this;
  }

  Response _getSwaggerYaml(Request req) {
    final file = File('swagger.yaml');
    
    return Response.ok(file.readAsBytesSync(), headers: {
      HttpHeaders.lastModifiedHeader: formatHttpDate(file.statSync().modified),
      HttpHeaders.acceptRangesHeader: 'bytes',
      HttpHeaders.contentTypeHeader: '.yaml',
    });
  }
}