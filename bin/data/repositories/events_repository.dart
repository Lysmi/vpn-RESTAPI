import 'package:get_it/get_it.dart';

import '../../domain/entities/events/balanceNotifyReceiver.dart' as entities;
import '../../domain/repositories/events_repository_interface.dart';
import '../providers/events_provider.dart';

class EventsRepository implements IEventsRepository {
  final EventsProvider _events = GetIt.I<EventsProvider>();

  @override
  void addBalanceNotifyReceiver(entities.BalanceNotifyReceiver receiver) {
    _events.addBalanceNotifyReceiver(receiver);
  }

  @override
  Future<List<entities.BalanceNotifyReceiver>> getAllBalanceNotifyReceivers() {
    // TODO: implement getAllBalanceNotifyReceivers
    return _events.getAllBalanceNotifyReceivers();
  }

  @override
  Future<List<entities.BalanceNotifyReceiver>>
      getBalanceNotifyReceiversByUserId(String id) {
    return _events.getBalanceNotifyReceiversByUserId(id);
  }
}
