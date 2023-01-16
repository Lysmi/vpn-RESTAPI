import 'package:get_it/get_it.dart';

import '../../data/repositories/events_repository.dart';
import '../entities/events/balanceNotifyReceiver.dart';
import '../repositories/events_repository_interface.dart';
import 'get_user_usecase.dart';

class EventsUsecases {
  IEventsRepository events = GetIt.I<IEventsRepository>();

  Future<List<BalanceNotifyReceiver>> getAllBalanceNotifyReceivers() {
    return events.getAllBalanceNotifyReceivers();
  }

  Future<List<BalanceNotifyReceiver>> getBalanceNotifyReceiversByUserId(
      String id) {
    return events.getBalanceNotifyReceiversByUserId(id);
  }

  void addBalanceNotifyReceiver(String userId, String ip) async {
    GetUserUsecase userUsecase = GetIt.I<GetUserUsecase>();
    final user = await userUsecase.getUserById(userId);
    if (user != null) {
      events
          .addBalanceNotifyReceiver(BalanceNotifyReceiver(ip: ip, user: user));
    }
  }

  void notifySubscribers(String id) async {
    print("usecase notify start");
    for (var element in (await events.getBalanceNotifyReceiversByUserId(id))) {
      print("notify`s ip: ${element.ip}");
      element.sendOut();
    }
  }
}
