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
            icon: const Icon(Icons.arrow_back_ios_rounded),
            color: Colors.white60,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "${passInfo.passName}",
            style: const TextStyle(color: Colors.white60),
          ),
          backgroundColor: appGreen,
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            buildDetailContainer("PassName", '${passInfo.passName}'),
            buildDetailContainer("Username", '${passInfo.username}'),
            buildDetailContainer("Password", '${passInfo.password}'),
          ],
        ),
      ),
    );
  }

  Widget buildDetailContainer(String title, String value) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white12,
        ),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(13.0),
        alignment: Alignment.center,
        child: detailRow(title, value));
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
          style: const TextStyle(fontSize: 25.0, color: Colors.white70),
        ),
      ],
    );
  }
}
