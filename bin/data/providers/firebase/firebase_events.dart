import 'package:firebase_dart/firebase_dart.dart';
import 'package:firebase_dart/implementation/testing.dart';

import '../../../domain/entities/events/balanceNotifyReceiver.dart' as entities;
import '../events_provider.dart';

class FirebaseEvents implements EventsProvider {
  FirebaseApp? app;
  FirebaseDatabase? db;
  @override
  void addBalanceNotifyReceiver(entities.BalanceNotifyReceiver receiver) {
    var ref = db!.reference().child("Events/BalanceNotify");
    ref.update({receiver.user.id: receiver.toMap()});
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
    await FirebaseTesting.setup();
    var options = FirebaseOptions(
        appId: '1:567779820391:web:2471a31bdfa94ecfdd65c2',
        apiKey: 'AIzaSyBGyJHCcS-OyhdlgldtH0evXey321WJlN8',
        projectId: 'vpnrest-cbdd5',
        messagingSenderId: 'ignore',
        authDomain: 'vpnrest-cbdd5.firebaseapp.com');

    app = await Firebase.initializeApp(options: options);
    db = FirebaseDatabase(app: app, databaseURL: 'mem://user.database/');
  }
}
