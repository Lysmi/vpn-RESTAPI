import 'dart:io';

import 'package:firebase_dart/core.dart';
import 'package:firebase_dart/database.dart';
import 'package:firebase_dart/implementation/testing.dart';
import 'package:get_it/get_it.dart';
import 'package:neat_periodic_task/neat_periodic_task.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart';
import 'package:stormberry/stormberry.dart';
import 'package:vpn_rest_server/environment_config.dart';
import 'controllers/config_controller.dart';
import 'controllers/event_contoller.dart';
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
Future<void> getItRegister() async {
  var db = Database(
    host: EnvironmentConfig.host,
    port: EnvironmentConfig.port.toInt(),
    database: EnvironmentConfig.database,
    user: EnvironmentConfig.username,
    password: EnvironmentConfig.password,
    useSSL: false,
  );
  await registrationFirebase();
  GetIt.I.registerSingleton<Database>(db);
  GetIt.I.registerSingleton<DataProvider>(FirebaseData()..registration());
  GetIt.I.registerSingleton<EventsProvider>(FirebaseEvents()..registration());

  repositoryRegister();
}

Future<void> registrationFirebase() async {
  await FirebaseTesting.setup();
  var options = FirebaseOptions(
      appId: '1:567779820391:web:2471a31bdfa94ecfdd65c2',
      apiKey: 'AIzaSyBGyJHCcS-OyhdlgldtH0evXey321WJlN8',
      projectId: 'vpnrest-cbdd5',
      messagingSenderId: 'ignore',
      authDomain: 'vpnrest-cbdd5.firebaseapp.com');

  var app = await Firebase.initializeApp(options: options);
  var db = FirebaseDatabase(
      app: app,
      databaseURL:
          'https://vpnrest-cbdd5-default-rtdb.europe-west1.firebasedatabase.app/');
  GetIt.I.registerSingleton<FirebaseDatabase>(db);
}

void repositoryRegister() {
  GetIt.I.registerSingleton<IUsersRepository>(UserRepository());
  GetIt.I.registerSingleton<IServerRepository>(ServerRepository());
  GetIt.I.registerSingleton<IEventsRepository>(EventsRepository());
}

void dailyDecreaseBalanceRun() {
  final scheduler = NeatPeriodicTaskScheduler(
    interval: Duration(days: 1),
    name: 'dailyDecreaseBalance',
    timeout: Duration(seconds: 5),
    task: () async => UserBalanceUsecase.dailyDeacreaseBalance(),
    minCycle: Duration(hours: 2),
  );
  scheduler.start();
}

void main(List<String> args) async {
  initializeJsonMapper();

  // Use any available host or container IP (usually `0.0.0.0`).
  await getItRegister();
  final ip = InternetAddress.anyIPv4;
  final swaggerPath = 'swagger.yaml';

  final router = Router();

  ConfigController(router: router).addHandlers();
  UserController(router: router).addHandlers();
  ServerController(router: router).addHandlers();
  EventController(router: router).addHandlers();

  final swaggerHandler = SwaggerUI(swaggerPath, title: 'Swagger Test');
  router.get("/swagger", swaggerHandler.call);

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  dailyDecreaseBalanceRun();
  print('Server listening on port ${server.port}');
}
