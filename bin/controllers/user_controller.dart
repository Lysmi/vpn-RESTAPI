import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';
import 'package:uuid/uuid.dart';

import '../domain/usecases/get_user_usecase.dart';
import 'controller_interface.dart';

class UserController extends IController {
  UserController({required super.router});

  final _url = '/api/user';

  final GetUserUsecase _getUserUsecase = GetIt.I<GetUserUsecase>();
  
  @override
  UserController addHandlers() {
    router
      ..get('$_url/<userId>', _getUserByIdHandler)
      ..get(_url, _getAllUsers)
      ..post(_url, _postAddUserHandler)
      ..patch(
          '$_url/<userId>/addToBalance/<balance>', _patchAddUserBalanceHandler)
      ..patch(_url, _patchUpdateUser);
    return this;
  }

  Future<Response> _getUserByIdHandler(Request req, Uuid id) async {
    var user = await _getUserUsecase
        .getUserById(id);
    return Response.ok(JsonMapper.serialize(user));
  }

  Response _postAddUserHandler(Request req) {
    //TODO implement
    return Response.unauthorized('');
  }

  Response _patchAddUserBalanceHandler(
      Request req, String userId, int balance) {
    //TODO implement
    return Response.ok('');
  }

  Future<Response> _getAllUsers(Request req) async {
    var users = await _getUserUsecase.getAllUsers();
    return Response.unauthorized(JsonMapper.serialize(users));
  }

  Response _patchUpdateUser(Request req, int id) {
    //TODO implement
    return Response.unauthorized('');
  }
}
