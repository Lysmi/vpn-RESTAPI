import 'package:get_it/get_it.dart';

import '../entities/events/balance_notify_receiver.dart';
import '../repositories/events_repository_interface.dart';
import 'get_user_usecase.dart';

class EventsUsecases {
  // ignore: unnecessary_late
  static late IEventsRepository events = GetIt.I<IEventsRepository>();

  static Future<List<BalanceNotifyReceiver>> getAllBalanceNotifyReceivers() {
    return events.getAllBalanceNotifyReceivers();
  }

  static Future<List<BalanceNotifyReceiver>> getBalanceNotifyReceiversByUserId(
      String id) {
    return events.getBalanceNotifyReceiversByUserId(id);
  }

  static void addBalanceNotifyReceiver(
      {required String userId, required String ip}) async {
    final user = await GetUserUsecase.getUserById(userId);
    if (user != null) {
      events
          .addBalanceNotifyReceiver(BalanceNotifyReceiver(ip: ip, user: user));
    } else {}
  }

  static void notifySubscribers(String id) async {
    print("usecase notify start");
    for (var element in (await events.getBalanceNotifyReceiversByUserId(id))) {
      print("notify`s ip: ${element.ip}");
      element.sendOut();
    }
  }
}
