class PassInfo {
  late int id;
  String? passName;
  String? username;
  String? password;

  PassInfo(this.passName, this.username, this.password);
  PassInfo.withId(this.id, this.passName, this.username, this.password);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["passName"] = passName;
    map["username"] = username;
    map["password"] = password;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  PassInfo.fromObject(dynamic o) {
    this.id = int.tryParse(o["id"]) ?? o["id = 0"];
    this.passName = o["passName"];
    this.username = o["username"];
    this.password = o["password"];
  }
}
