import 'package:flutter/material.dart';
import 'package:password_app/constants/constants.dart';
import 'package:password_app/models/pass_info.dart';

class PasswordDetail extends StatelessWidget {
  PasswordDetail({Key? key, required this.passInfo}) : super(key: key);

  PassInfo passInfo;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            color: Colors.white60,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "${passInfo.passName}",
            style: TextStyle(color: Colors.white60),
          ),
          backgroundColor: appGreen,
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            buildPassNameDetail(),
            buildUsernameDetail(),
            buildPasswordDetail(),
          ],
        ),
      ),
    );
  }

  Widget buildPassNameDetail() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white12,
        ),
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(13.0),
        alignment: Alignment.center,
        child: detailRow('PassName', '${passInfo.passName}'));
  }

  Widget buildUsernameDetail() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white12,
        ),
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(13.0),
        alignment: Alignment.center,
        child: detailRow('Username', '${passInfo.username}'));
  }

  Widget buildPasswordDetail() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white12,
        ),
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(13.0),
        alignment: Alignment.center,
        child: detailRow('Password', '${passInfo.password}'));
  }

  Widget detailRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 18.0, color: appGreen2),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25.0, color: Colors.white70),
        ),
      ],
    );
  }
}
