import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:shelf/shelf.dart';

import '../domain/entities/user.dart';
import '../domain/usecases/add_user_usecase.dart';
import '../domain/usecases/get_user_usecase.dart';
import '../domain/usecases/user_balance_usecase.dart';
import 'controller_interface.dart';

class UserController extends IController {
  UserController({required super.router});

  @override
  UserController addHandlers() {
    router
      ..get("/users/<userId>", _getUserById)
      ..get("/users", _getAllUsers)
      ..get("/users/<userId>/qrCode", _getUserQR)
      ..get("/users/<userId>/config", _getUserConfig)
      ..patch("/users/<userId>/useFreePeriod", _patchUseFreePeriod)
      ..post("/users", _postAddUser)
      ..patch("/users/<userId>/addToBalance/<balance>", _patchAddUserBalance)
      ..patch("/users", _patchUpdateUser);
    return this;
  }

  Future<Response> _getUserById(Request req, String userId) async {
    var user = await GetUserUsecase.getUserById(userId);
    if (user == null) {
      return Response.badRequest(
          body: jsonEncode({"error": "User don`t exist"}));
    }
    return Response.ok(JsonMapper.serialize(user));
  }

  Future<Response> _getUserQR(Request req, String userId) async {
    var qr = await GetUserUsecase.getUserQR(userId);
    if (qr == null) {
      return Response.badRequest(
          body:
              jsonEncode({"error": "User don`t exist or haven`t sertificate"}));
    }
    return Response.ok(
      qr,
      headers: {
        'Content-Type': 'image/png',
      },
    );
  }

  Future<Response> _getUserConfig(Request req, String userId) async {
    var config = await GetUserUsecase.getUserConfig(userId);
    if (config == null) {
      return Response.badRequest(
          body:
              jsonEncode({"error": "User don`t exist or haven`t sertificate"}));
    }
    return Response.ok(jsonEncode({
      "configFile": config,
    }));
  }

  Future<Response> _patchUseFreePeriod(Request req, String userId) async {
    var res = await UserBalanceUsecase.useFreePeriod(userId);
    switch (res) {
      case null:
        return Response.badRequest(
            body: jsonEncode({"error": "User don`t exist"}));
      case -1:
        return Response.badRequest(
            body: jsonEncode({"error": "Free Period already used"}));
      default:
        return Response.ok(jsonEncode({
          "message": "Free Period used",
          "newBalance": res,
        }));
    }
  }

  // postData = {
  //   'telegramId': 212,
  //   'username': 'lysmi',
  // }
  Future<Response> _postAddUser(Request req) async {
    var body = await req.readAsString();
    var postData = jsonDecode(body);
    var userCheck = await GetUserUsecase.getUserById(postData['telegramId']);
    User newUser;
    if (userCheck != null) {
      newUser = userCheck.copyWith(username: postData['username']);
    } else {
      newUser =
          User(id: postData['telegramId'], username: postData['username']);
    }
    var userId = await AddUserUsecase.addUsers(newUser);
    return Response.ok(jsonEncode({"userId": userId}));
  }

  Future<Response> _patchAddUserBalance(
      Request req, String userId, String balanceString) async {
    var balance = int.tryParse(balanceString);
    if (balance == null) {
      return Response.badRequest(
          body: jsonEncode({"error": "Balance must be integer"}));
    }
    var res = await UserBalanceUsecase.addBalanceToUser(balance, userId);
    if (res == null) {
      return Response.badRequest(body: "User didn`t found");
    }
    return Response.ok(jsonEncode({"newBalance": res}));
  }

  Future<Response> _getAllUsers(Request req) async {
    var users = await GetUserUsecase.getAllUsers();
    return Response.ok(JsonMapper.serialize(users));
  }

  Response _patchUpdateUser(Request req, int id) {
    //TODO implement
    return Response.ok('Unimplement\n');
  }
}
