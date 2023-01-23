import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';

import '../domain/entities/sertificate.dart';
import '../domain/entities/user.dart';
import '../domain/usecases/add_user_usecase.dart';
import '../domain/usecases/get_user_usecase.dart';
import '../domain/usecases/misc_user_usecase.dart';
import '../domain/usecases/user_balance_usecase.dart';
import 'controller_interface.dart';

class UserController extends IController {
  UserController({required super.router});

  @override
  UserController addHandlers() {
    router
      ..get("/users/<userId>", _getUserById) // get user by id
      ..get("/users", _getAllUsers) // get user
      ..get("/users/<userId>/qrCode", _getUserQR) // get qr confg
      ..patch("/users/<userId>/useFreePeriod",
          _patchUseFreePeriod) // start free/test period
      ..post("/users", _postAddUser) // add user
      ..patch("/users/<userId>/addToBalance/<balance>",
          _patchAddUserBalance) // increase balance
      ..patch("/users", _patchUpdateUser) // update user
      ..delete("/users/<userId>", _deleteUserById);
    return this;
  }

  Future<Response> _deleteUserById(Request req, String userId) async {
    final miscUserUsecase = GetIt.I<MiscUserUsecase>();
    var user = await miscUserUsecase.removeUser(userId);
    if (user == null) {
      return Response.badRequest(
          body: jsonEncode({"error": "User don`t exist"}));
    }
    return Response.ok(JsonMapper.serialize(user));
  }

  Future<Response> _getUserById(Request req, String userId) async {
    final getUserUsecase = GetIt.I<GetUserUsecase>();
    var user = await getUserUsecase.getUserById(userId);
    if (user == null) {
      return Response.badRequest(
          body: jsonEncode({"error": "User don`t exist"}));
    }
    return Response.ok(JsonMapper.serialize(user));
  }

  Future<Response> _getUserQR(Request req, String userId) async {
    final getUserUsecase = GetIt.I<GetUserUsecase>();
    var qr = await getUserUsecase.getUserQR(userId);
    if (qr == null) {
      return Response.badRequest(
          body: jsonEncode({"error": "User don`t exist"}));
    }
    return Response.ok(
      qr,
      headers: {
        'Content-Type': 'image/png',
      },
    );
  }

  Future<Response> _patchUseFreePeriod(Request req, String userId) async {
    final balanceUsecase = UserBalanceUsecase();
    var res = await balanceUsecase.useFreePeriod(userId);
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
    final addUserUsecase = GetIt.I<AddUserUsecase>();
    var body = await req.readAsString();
    var postData = jsonDecode(body);
    var userId = await addUserUsecase.addUsers(
        User(id: postData['telegramId'], username: postData['username']));
    return Response.ok(jsonEncode({"userId": userId}));
  }

  Future<Response> _patchAddUserBalance(
      Request req, String userId, String _balance) async {
    final balanceUsecase = UserBalanceUsecase();
    var balance = int.tryParse(_balance);
    if (balance == null) {
      return Response.badRequest(
          body: jsonEncode({"error": "Balance must be integer"}));
    }
    var res = await balanceUsecase.addBalanceToUser(balance, userId);
    if (res == null) {
      return Response.badRequest(body: "User didn`t found");
    }
    return Response.ok(jsonEncode({"newBalance": res}));
  }

  Future<Response> _getAllUsers(Request req) async {
    final getUserUsecase = GetIt.I<GetUserUsecase>();
    var users = await getUserUsecase.getAllUsers();
    return Response.ok(JsonMapper.serialize(users));
  }

  Response _patchUpdateUser(Request req, int id) {
    //TODO implement
    return Response.ok('Unimplement\n');
  }
}
