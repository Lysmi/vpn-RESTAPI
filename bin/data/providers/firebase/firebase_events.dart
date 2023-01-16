import 'package:firebase_dart/firebase_dart.dart';
import 'package:firebase_dart/implementation/testing.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entities/events/balanceNotifyReceiver.dart' as entities;
import '../events_provider.dart';

class FirebaseEvents implements EventsProvider {
  FirebaseDatabase? db;
  @override
  void addBalanceNotifyReceiver(entities.BalanceNotifyReceiver receiver) {
    var ref = db!.reference().child("Events/BalanceNotify/${receiver.user.id}");
    ref = ref.push();
    ref.set(receiver.toMap());
  }

  @override
  Future<List<entities.BalanceNotifyReceiver>>
      getAllBalanceNotifyReceivers() async {
    var ref = db!.reference().child("Events/BalanceNotify");
    var receivers = await ref.get();
    if (receivers == null) {
      return [];
    } else {
      receivers as Map;
      receivers = receivers.values.toList();
      receivers =
          (receivers as List).map((e) => receivers.User.fromMap(e)).toList();
    }
    return (receivers as List<entities.BalanceNotifyReceiver>);
  }

  @override
  Future<List<entities.BalanceNotifyReceiver>>
      getBalanceNotifyReceiversByUserId(String id) async {
    var ref = db!.reference().child("Events/BalanceNotify/$id");
    var receivers = await ref.get();
    if (receivers == null) {
      return [];
    } else {
      receivers as Map;
      receivers = receivers.values.toList();
      receivers =
          (receivers as List).map((e) => receivers.User.fromMap(e)).toList();
    }
    return (receivers as List<entities.BalanceNotifyReceiver>);
  }

  @override
  void registration() async {
    db = GetIt.I<FirebaseDatabase>();
  }
}
