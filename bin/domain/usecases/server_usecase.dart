// ignore_for_file: unnecessary_late

import 'package:get_it/get_it.dart';

import '../entities/region.dart';
import '../entities/server.dart';
import '../repositories/regions_repository_interface.dart';
import '../repositories/servers_repository_interface.dart';

class ServerUsecase {
  static late IServerRepository servers = GetIt.I<IServerRepository>();
  static late IRegionsRepository regions = GetIt.I<IRegionsRepository>();

  static void addServer(Server server) async {
    servers.addServer(server);
  }

  static Future<List<Server>> getServers() async {
    return servers.getAllServers();
  }

  static Future<List<Server>> getServersByRegion(Region region) async {
    var allServers = await servers.getAllServers();
    return allServers.where((element) => element.region == region).toList();
  }

  static Future<Region?> getRegionById(String id) async {
    return regions.getRegionById(id);
  }

  static Future<List<Region>> getRegions() async {
    return regions.getAllRegions();
  }

  static void addRegion(Region region) async {
    return regions.addRegion(region);
  }

  static Future<Server> chooseServer(Region region) async {
    var serversList = (await getServersByRegion(region));
    serversList.sort(((a, b) => a.countUsers.compareTo(b.countUsers)));
    if (serversList.isEmpty) {
      throw Exception("EmptyServerList");
    } else {
      return serversList.first;
    }
  }
}
