import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_app/data/db_helper.dart';
import 'package:password_app/models/pass_info.dart';
import 'package:password_app/screens/password_detail.dart';

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

  List<Color> colors = [
    Color(0xb58ecae6),
    Color(0xb7219ebc),
    Color(0x88023047),
    Color(0x88ffb703),
    Color(0x81fb8500)
  ];
  final random = Random();
  Color colorRandom() {
    return colors[random.nextInt(5)];
  }

  @override
  void initState() {
    getPasswords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Password Informations"),
          backgroundColor: Color(0xb58ecae6),
        ),
        body: buildPassInfoList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xb58ecae6),
          splashColor: Color(0x81fb8500),
          onPressed: () {
            goToPasswordAdd();
          },
          child: Icon(Icons.add),
          tooltip: "Add new password",
        ),
      ),
    );
  }

  ListView buildPassInfoList() {
    return ListView.builder(
        itemCount: passInfoCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            elevation: 3.0,
            child: ListTile(
              tileColor: colorRandom(),
              title: Text("${passInfos[position].passName}"),
              subtitle: Text("${passInfos[position].username}"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => PasswordDetail(
                              passInfo: passInfos[position],
                            )));
              },
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
      setState(() {
        print("getPassword.data : ${data.length}");
        passInfos = data;
        passInfoCount = data.length;
      });
    });
  }
}
