class PassInfo {
  late int id = 0;
  String? passName;
  String? username;
  String? password;

  PassInfo(this.passName, this.username, this.password);
  PassInfo.withId(this.id, this.passName, this.username, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["passName"] = passName;
    map["username"] = username;
    map["password"] = password;
    return map;
  }

  PassInfo.fromObject(dynamic o) {
    id = int.tryParse(o["id"].toString()) ?? 0;
    passName = o["passName"];
    username = o["username"];
    password = o["password"];
  }
}
