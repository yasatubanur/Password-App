import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:password_app/constants/constants.dart';
import 'package:password_app/data/db_helper.dart';
import 'package:password_app/models/pass_info.dart';
import 'package:password_app/screens/widgets/text_field_widget.dart';

class AddPassword extends StatefulWidget {
  const AddPassword({Key? key}) : super(key: key);

  @override
  _AddPasswordState createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {
  late PassInfo passInfo;

  var txtPassName = TextEditingController();
  var txtUsername = TextEditingController();
  var txtPassword = TextEditingController();
  var dbHelper = DbHelper();

  bool _validatePassName = false;
  bool _validateUsername = false;
  bool _validatePassword = false;

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
            "Add Password",
            style: TextStyle(color: Colors.white60),
          ),
          backgroundColor: appGreen,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white60,
                backgroundColor: Colors.transparent,
              ),
              onPressed: () {
                addPassword();
              },
              child: Text("Save"),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15),
              buildTextField(
                  "PassName",
                  "Enter a password name",
                  _validatePassName ? "Please enter a app name" : null,
                  txtPassName),
              buildTextField(
                  "Username",
                  "Enter a username",
                  _validateUsername ? "Please enter a username" : null,
                  txtUsername),
              buildTextField(
                  "Password",
                  "Enter a password",
                  _validatePassword ? "Please enter a password" : null,
                  txtPassword),
            ],
          ),
        ),
      ),
    );
  }

  void addPassword() async {
    setState(() {
      _validatePassName = txtPassName.text.isEmpty;
      _validateUsername = txtUsername.text.isEmpty;
      _validatePassword = txtPassword.text.isEmpty;
    });
    if (_validatePassName == false &&
        _validateUsername == false &&
        _validatePassword == false) {
      var _ = await dbHelper.insert(
          PassInfo(txtPassName.text, txtUsername.text, txtPassword.text));
      Navigator.pop(context, true);
    }
  }
}
