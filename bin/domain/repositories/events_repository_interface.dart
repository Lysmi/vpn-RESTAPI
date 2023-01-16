import '../entities/events/balanceNotifyReceiver.dart' as entities;

abstract class IEventsRepository {
  Future<List<entities.BalanceNotifyReceiver>> getAllBalanceNotifyReceivers();
  Future<List<entities.BalanceNotifyReceiver>>
      getBalanceNotifyReceiversByUserId(String id);
  void addBalanceNotifyReceiver(entities.BalanceNotifyReceiver receiver);
}
