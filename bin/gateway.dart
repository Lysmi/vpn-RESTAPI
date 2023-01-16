import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart';
import 'package:stormberry/stormberry.dart';
import 'package:vpn_rest_server/environment_config.dart';
import 'controllers/config_controller.dart';
import 'controllers/server_controller.dart';
import 'controllers/user_controller.dart';
import 'data/providers/data_provider.dart';
import 'data/providers/events_provider.dart';
import 'data/providers/firebase/firebase_data.dart';
import 'data/providers/firebase/firebase_events.dart';
import 'data/repositories/events_repository.dart';
import 'data/repositories/servers_repository.dart';
import 'data/repositories/users_repository.dart';
import 'domain/repositories/events_repository_interface.dart';
import 'domain/repositories/servers_repository_interface.dart';
import 'domain/repositories/users_repository_interface.dart';
import 'domain/usecases/add_user_usecase.dart';
import 'domain/usecases/events_usecases.dart';
import 'domain/usecases/get_user_usecase.dart';
import 'domain/usecases/server_usecase.dart';
import 'domain/usecases/user_balance_usecase.dart';
import 'gateway.mapper.g.dart' show initializeJsonMapper;

//register all get_it models
void getItRegister() {
  var db = Database(
    host: EnvironmentConfig.host,
    port: EnvironmentConfig.port.toInt(),
    database: EnvironmentConfig.database,
    user: EnvironmentConfig.username,
    password: EnvironmentConfig.password,
    useSSL: false,
  );
  GetIt.I.registerSingleton<Database>(db);
  GetIt.I.registerSingleton<DataProvider>(FirebaseData()..registration());
  GetIt.I.registerSingleton<EventsProvider>(FirebaseEvents());

  repositoryRegister();
  usecasesRegister();
}

void repositoryRegister() {
  GetIt.I.registerSingleton<IUsersRepository>(UserRepository());
  GetIt.I.registerSingleton<IServerRepository>(ServerRepository());
  GetIt.I.registerSingleton<IEventsRepository>(EventsRepository());
}

void usecasesRegister() {
  GetIt.I.registerSingleton<GetUserUsecase>(GetUserUsecase());
  GetIt.I.registerSingleton<AddUserUsecase>(AddUserUsecase());
  GetIt.I.registerSingleton<ServerUsecase>(ServerUsecase());
  GetIt.I.registerSingleton<EventsUsecases>(EventsUsecases());
  GetIt.I.registerSingleton<UserBalanceUsecase>(UserBalanceUsecase());
}

void main(List<String> args) async {
  initializeJsonMapper();

  // Use any available host or container IP (usually `0.0.0.0`).
  getItRegister();
  final ip = InternetAddress.anyIPv4;
  final swaggerPath = 'swagger.yaml';

  final router = Router();

  ConfigController(router: router).addHandlers();
  UserController(router: router).addHandlers();
  ServerController(router: router).addHandlers();

  final swaggerHandler = SwaggerUI(swaggerPath, title: 'Swagger Test');
  router.get("/swagger", swaggerHandler.call);

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
