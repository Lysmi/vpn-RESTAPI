import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart';
import 'package:stormberry/stormberry.dart';
import 'package:vpn_rest_server/environment_config.dart';

import 'controllers/server_controller.dart';
import 'controllers/user_controller.dart';
import 'data/providers/data_provider_interface.dart';
import 'data/providers/postgresql/postgresql_data_provider.dart';
import 'data/repositories/users_repository.dart';
import 'domain/repositories/users_repository_interface.dart';

//register all get_it models
void getItRegister() {
  GetIt.I.registerSingleton<Database>(Database(
    host: EnvironmentConfig.host,
    port: EnvironmentConfig.port.toInt(),
    database: EnvironmentConfig.database,
    user: EnvironmentConfig.username,
    password: EnvironmentConfig.password,
  ));

  GetIt.I.registerSingleton<IDataProvider>(PostgresqlDataProvider());
  GetIt.I.registerSingleton<IUsersRepository>(UserRepository());
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  getItRegister();
  final ip = InternetAddress.anyIPv4;
  final swaggerPath = 'swagger.yaml';

  final _router = Router();

  UserController userController = UserController(router: _router).addHandlers();
  ServerController serverController =
      ServerController(router: _router).addHandlers();

  final swaggerHandler = SwaggerUI(swaggerPath, title: 'Swagger Test');

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
