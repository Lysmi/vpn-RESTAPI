import 'dart:async';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart';

class BetterSwaggerUi extends SwaggerUI {
 BetterSwaggerUi(
    super.fileSchemaPath, {
    super.title = 'Shelf Swagger',
    super.docExpansion = DocExpansion.list,
    super.syntaxHighlightTheme = SyntaxHighlightTheme.agate,
    super.deepLink = false,
    super.persistAuthorization = false,
  }); 
 
 FutureOr<Response> call(Request request) {
    final file = File(super.fileSchemaPath);
    final mainSpec = basename(file.path);
    final dirParent = file.parent;
    final uri = request.url;
    final path = uri.path;

    if (path.contains('yaml') || path.contains('json')) {
      var filePath = _resolveFilePath(dirParent, path);
      final file = File(filePath);
      String? contentType;
      if (filePath.endsWith('.yaml') || filePath.endsWith('.yml')) {
        contentType = 'application/yaml';
      } else if (filePath.endsWith('.json')) {
        contentType = 'application/json';
      }
      return Response.ok(file.readAsBytesSync(), headers: {
        HttpHeaders.lastModifiedHeader: formatHttpDate(file.statSync().modified),
        HttpHeaders.acceptRangesHeader: 'bytes',
        if (contentType != null) HttpHeaders.contentTypeHeader: contentType,
      });
    }
    return Response.ok(headers: {
      HttpHeaders.contentTypeHeader: ContentType('text', 'html', charset: 'utf-8').toString(),
    }, '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta
    name="description"
    content="SwaggerUI"
  />
  <title>$title</title>
  <link rel="stylesheet" href="https://unpkg.com/swagger-ui-dist@4.5.0/swagger-ui.css" />
</head>
<body>
<div id="swagger-ui"></div>
<script src="https://unpkg.com/swagger-ui-dist@4.5.0/swagger-ui-bundle.js" crossorigin></script>

<script>
  window.onload = () => {
    window.ui = SwaggerUIBundle({
      dom_id: '#swagger-ui',
      docExpansion: '${docExpansion.name}',
      deepLinking: $deepLink,
      url: "${file.path /* Все расширение написанно только для этой строки */}", 
      syntaxHighlight: {
        activate: true,
        theme: '${syntaxHighlightTheme.theme}',
      },
      persistAuthorization: $persistAuthorization,
    });
  };
</script>
</body>
</html>
''');
  }
  
  String _resolveFilePath(Directory dir, String path) {
    final subs = dir.listSync(recursive: true).where((file) => file is Directory).toList();
    for (var subDir in subs) {
      var subDirPath = subDir.path.replaceFirst('${dir.path}${Platform.pathSeparator}', '');
      final candidate = '${subDirPath}/${basename(path)}'.replaceAll('\\', '/');
      if (path.endsWith(candidate)) {
        return '${dir.path}/$candidate'.replaceAll('\\', '/');
      }
    }

    return '${dir.path}/${basename(path)}';
  }
}
