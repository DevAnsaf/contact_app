class Contacts {
  int? id;
  String? Name;
  String? ContactNumber;
  String? info;
  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['Name'] = Name!;
    mapping['ContactNumber'] = ContactNumber!;
    mapping['info'] = info;
    return mapping;
  }
}
