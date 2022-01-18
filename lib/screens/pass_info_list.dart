import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_app/constants/constants.dart';
import 'package:password_app/data/db_helper.dart';
import 'package:password_app/models/pass_info.dart';
import 'package:password_app/screens/password_detail.dart';

import 'add_password.dart';
import 'alert_dialog_widget.dart';
import 'edit_password_page.dart';

class PassInfoList extends StatefulWidget {
  const PassInfoList({Key? key}) : super(key: key);

  @override
  _PassInfoListState createState() => _PassInfoListState();
}

class Operations {
  Options options;
  PassInfo passInfo;

  Operations(this.options, this.passInfo);
}

enum Options { edit, delete }

class _PassInfoListState extends State<PassInfoList> {
  var dbHelper = DbHelper();
  late List<PassInfo> passInfos;

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
          title: const Text("Password Informations",
              style: TextStyle(color: Colors.white60)),
          backgroundColor: appGreen,
        ),
        body: buildPassInfoList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: appGreen,
          onPressed: () {
            goToPasswordAdd();
          },
          child: const Icon(Icons.add, color: Colors.white60),
          tooltip: "Add new password",
        ),
      ),
    );
  }

  buildPassInfoList() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListView.builder(
          itemCount: passInfos.length,
          itemBuilder: (BuildContext context, int position) {
            return Card(
              color: Colors.white12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.0),
                  side: BorderSide(color: appGreen, width: 2.0)),
              child: ListTile(
                title: Text(
                  "${passInfos[position].passName}",
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  "${passInfos[position].username}",
                  style: TextStyle(color: appGreen2),
                ),
                trailing: buildPopupMenuButton(position),
                onTap: () {
                  goToDetailPage(context, position);
                },
              ),
            );
          }),
    );
  }

  PopupMenuButton<Operations> buildPopupMenuButton(int position) {
    return PopupMenuButton<Operations>(
      color: appGreen,
      icon: Icon(Icons.more_vert, color: appGreen2),
      onSelected: selectProcess,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Operations>>[
        PopupMenuItem(
          child: const Text("Edit"),
          value: Operations(Options.edit, passInfos[position]),
        ),
        PopupMenuItem(
          child: const Text("Delete"),
          value: Operations(Options.delete, passInfos[position]),
        ),
      ],
    );
  }

  Future<dynamic> goToDetailPage(BuildContext context, int position) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PasswordDetail(
                  passInfo: passInfos[position],
                )));
  }

  void goToPasswordAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddPassword()));
    if (result != null) {
      if (result) getPasswords();
    }
  }

  void getPasswords() async {
    var passInfosFuture = dbHelper.getPassInfos();
    passInfosFuture.then((data) {
      setState(() {
        passInfos = data;
      });
    });
  }

  _showDialog(BuildContext context, Future<int> Function() delete) {
    VoidCallback continueCallBack = () => {
          Navigator.of(context).pop(),
          delete(),
        };
    BlurryDialog alert = BlurryDialog("Delete",
        "Are you sure you want to delete this password?", continueCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void selectProcess(Operations operations) async {
    switch (operations.options) {
      case Options.delete:
        _showDialog(context, () async {
          int result = await dbHelper.delete(operations.passInfo.id);
          getPasswords();
          return result;
        });
        break;
      case Options.edit:
        goToEditPage(context, operations.passInfo);
        break;
      default:
    }
  }

  Future<dynamic> goToEditPage(BuildContext context, PassInfo passInfo) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditPassword(passInfo)));
    if (result != null) {
      if (result) getPasswords();
    }
  }
}
