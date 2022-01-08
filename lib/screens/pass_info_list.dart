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
    Color(0xe6c2969e),
    Color(0xe6a07780),
    Color(0xe666784b),
    Color(0xe687986a)
  ];
  final random = Random();
  Color colorRandom() {
    return colors[random.nextInt(4)];
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
          title: Text("Password Informations"),
          backgroundColor: Color(0xff87986a),
        ),
        body: buildPassInfoList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff87986a),
          splashColor: Color(0xffa07780),
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
              trailing: PopupMenuButton(
                color: Color(0xade5b6c0),
                onSelected: choiceAction,
                itemBuilder: (BuildContext context) {
                  return choices.map((choice) {
                    return PopupMenuItem(
                      child: Text(choice),
                      value: choice,
                    );
                  }).toList();
                },
              ),
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
      print("Edit");
    } else if (choice == choices[1]) {
      print("DElete");
    }
  }
}
