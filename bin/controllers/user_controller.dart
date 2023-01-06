import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';

import '../domain/entities/sertificate.dart';
import '../domain/entities/user.dart';
import '../domain/usecases/add_user_usecase.dart';
import '../domain/usecases/get_user_usecase.dart';
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

  Future<Response> _getUserByIdHandler(Request req, String userId) async {
    final getUserUsecase = GetIt.I<GetUserUsecase>();
    var user = await getUserUsecase.getUserById(userId);
    return Response.ok(JsonMapper.serialize(user));
  }

  // postData = {
  //   'telegramId': 212,
  //   'username': 'lysmi',
  // }
  Future<Response> _postAddUserHandler(Request req) async {
    //TODO implement
    final addUserUsecase = GetIt.I<AddUserUsecase>();
    var postData = jsonDecode(await req.readAsString());
    var sertificate =
        await addUserUsecase.addUsers(User(telegramId: postData['telegramId']));
    return Response.ok(jsonEncode(JsonMapper.serialize(sertificate)));
  }

  Response _patchAddUserBalanceHandler(
      Request req, String userId, int balance) {
    //TODO implement
    return Response.ok('Hello, World!\n');
  }

  Future<Response> _getAllUsers(Request req) async {
    final getUserUsecase = GetIt.I<GetUserUsecase>();
    var users = await getUserUsecase.getAllUsers();
    return Response.ok(JsonMapper.serialize(users));
  }

  Response _patchUpdateUser(Request req, int id) {
    //TODO implement
    return Response.ok('Hello, World!\n');
  }
}
