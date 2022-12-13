import 'package:shelf/shelf.dart';

import 'controller_interface.dart';

class UserController extends IController {
  UserController({required super.router});

  @override
  UserController addHandlers() {
    router
      ..get("/users/<userId>", _getUserByIdHandler)
      ..get("/users", _getAllUsers)
      ..post("/users", _postAddUserHandler)
      ..patch(
          "/user/<userId>/addToBalance/<balance>", _patchAddUserBalanceHandler)
      ..patch("/users", _patchUpdateUser);
    return this;
  }

  Response _getUserByIdHandler(Request req, int userId) {
    //TODO implement
    return Response.ok('Hello, World!\n');
  }

  Response _postAddUserHandler(Request req) {
    //TODO implement
    return Response.ok('Hello, World!\n');
  }

  Response _patchAddUserBalanceHandler(Request req, int userId, int balance) {
    //TODO implement
    return Response.ok('Hello, World!\n');
  }

  Response _getAllUsers(Request req, int id) {
    //TODO implement
    return Response.ok('Hello, World!\n');
  }

  Response _patchUpdateUser(Request req, int id) {
    //TODO implement
    return Response.ok('Hello, World!\n');
  }
}
