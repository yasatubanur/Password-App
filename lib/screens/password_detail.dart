import 'package:flutter/material.dart';

class DetailPassword extends StatefulWidget {
  const DetailPassword({Key? key}) : super(key: key);

  @override
  _DetailPasswordState createState() => _DetailPasswordState();
}

class _DetailPasswordState extends State<DetailPassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Password Detail"),
          backgroundColor: Color(0xb58ecae6),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
