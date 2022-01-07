import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_app/data/db_helper.dart';
import 'package:password_app/models/pass_info.dart';

import 'add_password.dart';

class PassInfoList extends StatefulWidget {
  const PassInfoList({Key? key}) : super(key: key);

  @override
  _PassInfoListState createState() => _PassInfoListState();
}

class _PassInfoListState extends State<PassInfoList> {
  var dbHelper = DbHelper();
  late List<PassInfo> passInfos;
  int passInfoCount = 0;

  @override
  void initState() {
    getPasswords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Password Informations"),
        backgroundColor: Color(0xb58ecae6),
      ),
      body: buildPassInfoList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xb58ecae6),
        onPressed: () {
          goToPasswordAdd();
        },
        child: Icon(Icons.add),
        tooltip: "Add new password",
      ),
    );
  }

  ListView buildPassInfoList() {
    return ListView.builder(
        itemCount: passInfoCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Color(0xb58ecae6),
            elevation: 3.0,
            child: ListTile(
              title: Text("${passInfos[position].passName}"),
              subtitle: Text("${passInfos[position].username}"),
              onTap: () {},
            ),
          );
        });
  }

  void goToPasswordAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddPassword()));
    if (result != null) {
      if (result == true) {
        getPasswords();
      }
    }
  }

  void getPasswords() async {
    var passInfosFuture = dbHelper.getPassInfos();
    passInfosFuture.then((data) {
      passInfos = data;
      passInfoCount = data.length;
    });
  }
}
