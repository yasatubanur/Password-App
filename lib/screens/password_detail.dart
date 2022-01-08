import 'package:flutter/material.dart';
import 'package:password_app/models/pass_info.dart';

class PasswordDetail extends StatelessWidget {
  PasswordDetail({Key? key, required this.passInfo}) : super(key: key);

  PassInfo passInfo;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Password Detail"),
          backgroundColor: Color(0xff87986a),
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
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(13.0),
        alignment: Alignment.center,
        color: Color(0xffb5c99a),
        child: detailRow('PassName', '${passInfo.passName}'));
  }

  Widget buildUsernameDetail() {
    return Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(13.0),
        alignment: Alignment.center,
        color: Color(0xffb5c99a),
        child: detailRow('Username', '${passInfo.username}'));
  }

  Widget buildPasswordDetail() {
    return Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(13.0),
        alignment: Alignment.center,
        color: Color(0xffb5c99a),
        child: detailRow('Password', '${passInfo.password}'));
  }

  Widget detailRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 18.0),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 27.0,
          ),
        ),
      ],
    );
  }
}
