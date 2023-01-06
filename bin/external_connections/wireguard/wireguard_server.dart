import '../../domain/entities/sertificate.dart';
import '../../domain/entities/server.dart';
import 'wireguard_server_interface.dart';

class WireguardServer implements IWireguardServer {
  late String ip;
  String port = '8080';

  WireguardServer(Server server) {
    ip = server.ip;
  }

  @override
  Future<Sertificate> addNewPeer() {
    // TODO: implement addNewPeer
    throw UnimplementedError();
  }

  @override
  void deletePeer(String urlSafePublicKey) {
    // TODO: implement deletePeer
  }

  @override
  Future<String> getConfig(String urlSafePublicKey) {
    // TODO: implement getConfig
    throw UnimplementedError();
  }

  @override
  Future<String> getQRConfig(String urlSafePublicKey) {
    // TODO: implement getQRConfig
    throw UnimplementedError();
  }
}
