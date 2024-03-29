import 'dart:typed_data';

import '../../domain/entities/sertificate.dart';

abstract class IWireguardServer {
  Future<Sertificate> addNewPeer();
  Future<String> getConfig(String urlSafePublicKey);
  Future<Uint8List> getQRConfig(String urlSafePublicKey);
  void deletePeer(String urlSafePublicKey);
}
