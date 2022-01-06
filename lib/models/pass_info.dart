class PassInfo {
  late int id;
  String passName;
  String username;
  String password;

  PassInfo(this.passName, this.username, this.password);
  PassInfo.withId(this.id, this.passName, this.username, this.password);
}
