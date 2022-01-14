import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_app/constants/constants.dart';
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
    Color(0xe697A97C),
    Color(0xe6C9AE9B),
  ];
  final random = Random();
  Color colorRandom() {
    return colors[random.nextInt(2)];
  }

  List<String> choices = ["Detail", "Edit", "Delete"];

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
          title: Text("Password Informations",
              style: TextStyle(color: Colors.white60)),
          backgroundColor: appGreen,
        ),
        body: buildPassInfoList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: appGreen,
          splashColor: Color(0xe6a07780),
          onPressed: () {
            goToPasswordAdd();
          },
          child: Icon(Icons.add),
          tooltip: "Add new password",
        ),
      ),
    );
  }

  buildPassInfoList() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListView.builder(
          itemCount: passInfoCount,
          itemBuilder: (BuildContext context, int position) {
            return Card(
              color: Colors.white12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.0),
                  side: BorderSide(color: appGreen, width: 2.0)),
              child: ListTile(
                title: Text(
                  "${passInfos[position].passName}",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 19,
                  ),
                ),
                subtitle: Text(
                  "${passInfos[position].username}",
                  style: TextStyle(color: appGreen2),
                ),
                trailing: PopupMenuButton(
                  color: appGreen,
                  onSelected: choiceAction,
                  icon: Icon(Icons.more_vert, color: appGreen2),
                  itemBuilder: (BuildContext context) {
                    return choices.map((choice) {
                      return PopupMenuItem(
                        child: Text(
                          choice,
                          style: TextStyle(color: Colors.black),
                        ),
                        value: choice,
                      );
                    }).toList();
                  },
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PasswordDetail(
                                passInfo: passInfos[position],
                              )));
                },
              ),
            );
          }),
    );
  }

  void goToPasswordAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddPassword()));
    if (result == true) {
      getPasswords();
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

  void choiceAction(String choice) {
    if (choice == choices[0]) {
    } else if (choice == choices[1]) {
      print("DElete");
    }
  }

  void goToDetail(PassInfo passInfo) async {
    bool result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PasswordDetail(
                  passInfo: passInfo,
                )));
  }
}
