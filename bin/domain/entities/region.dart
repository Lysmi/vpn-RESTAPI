class Region {
  int? id;
  String regionName;

  Region({this.id, required this.regionName});

  Region copyWidth({id, regionName}) {
    return Region(
      regionName: regionName,
      id: id,
    );
  }
}
