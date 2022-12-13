import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:uuid/uuid.dart';

@jsonSerializable
class Region {
  String id;
  String regionName;

  Region({id, required this.regionName}) : id = id ?? Uuid().v4();

  Region copyWidth({id, regionName}) {
    return Region(
      regionName: regionName,
      id: id,
    );
  }
}
