import 'package:flutter/material.dart';
import 'package:password_app/constants/constants.dart';
import 'package:password_app/data/db_helper.dart';
import 'package:password_app/models/pass_info.dart';
import 'package:password_app/screens/widgets/text_field_widget.dart';

class EditPassword extends StatefulWidget {
  PassInfo passInfo;
  EditPassword(this.passInfo);

  @override
  _EditPasswordState createState() => _EditPasswordState(passInfo);
}

class _EditPasswordState extends State {
  late PassInfo passInfo;
  _EditPasswordState(this.passInfo);
  var txtPassName = TextEditingController();
  var txtUsername = TextEditingController();
  var txtPassword = TextEditingController();
  var dbHelper = DbHelper();

  bool _validatePassName = false;
  bool _validateUsername = false;
  bool _validatePassword = false;

  @override
  void initState() {
    txtPassName.text = passInfo.passName!;
    txtUsername.text = passInfo.username!;
    txtPassword.text = passInfo.password!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            color: Colors.white38,
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
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.transparent,
              ),
              onPressed: () {
                updatePassword();
              },
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white60),
              ),
            ),
          ],
        ),
        body: buildEditPassword(),
      ),
    );
  }

  buildEditPassword() {
    return Padding(
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
    );
  }

  void updatePassword() async {
    setState(() {
      _validatePassName = txtPassName.text.isEmpty;
      _validateUsername = txtUsername.text.isEmpty;
      _validatePassword = txtPassword.text.isEmpty;
    });

    if (_validatePassName == false &&
        _validateUsername == false &&
        _validatePassword == false) {
      var _ = await dbHelper.update(PassInfo.withId(
          passInfo.id, txtPassName.text, txtUsername.text, txtPassword.text));
      Navigator.pop(context, true);
    }
  }
}
