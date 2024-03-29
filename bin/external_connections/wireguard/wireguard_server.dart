import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../../domain/entities/sertificate.dart';
import '../../domain/entities/server.dart';
import 'wireguard_server_interface.dart';

class WireguardServer implements IWireguardServer {
  String port = '8383';
  Server server;

  WireguardServer(this.server);

  @override
  Future<Sertificate> addNewPeer() async {
    var responce = await http.get(
        Uri.http('${server.ip}:$port', '/v1/devices/wg0/peers/'),
        headers: {"Authorization": "Bearer capybara"});
    var peersIPs = (jsonDecode(responce.body) as List<dynamic>)
        .map((e) => e['allowed_ips'][0].split('/')[0].split('.')[3])
        .toList();
    var newIp = List.generate(255, ((index) => (index + 1)))
        .where((element) => !peersIPs.contains(element.toString()))
        .first;
    responce = await http.post(
        Uri.http('${server.ip}:$port', '/v1/devices/wg0/peers/'),
        headers: {
          "Authorization": "Bearer capybara",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "allowed_ips": ["10.13.37.$newIp/32"]
        }));
    var newPeer = jsonDecode(responce.body);
    return Sertificate(
        publicKey: newPeer["url_safe_public_key"],
        server: server,
        dateCreate: DateTime.now());
  }

  @override
  Future deletePeer(String urlSafePublicKey) async {
    try {
      await http.delete(
          // TODO если айпи недоступен сделай с этим что то удали запись, я хуй его знаю, код ломаться заебал
          Uri.http(
              '${server.ip}:$port', '/v1/devices/wg0/peers/$urlSafePublicKey/'),
          headers: {"Authorization": "Bearer capybara"});
    } catch (e) {}
  }

  @override
  Future<String> getConfig(String urlSafePublicKey) async {
    var res = await http.get(
        Uri.http('${server.ip}:$port',
            '/v1/devices/wg0/peers/$urlSafePublicKey/quick.conf'),
        headers: {"Authorization": "Bearer capybara"});
    return res.body;
  }

  @override
  Future<Uint8List> getQRConfig(String urlSafePublicKey) async {
    var res = await http.get(
        Uri.http('${server.ip}:$port',
            '/v1/devices/wg0/peers/$urlSafePublicKey/quick.conf.png'),
        headers: {"Authorization": "Bearer capybara"});
    return res.bodyBytes;
  }
}
