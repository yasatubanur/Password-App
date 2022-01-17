import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:password_app/constants/constants.dart';
import 'package:password_app/data/db_helper.dart';
import 'package:password_app/models/pass_info.dart';

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
              buildPassNameField(),
              buildUsernameField(),
              buildPasswordField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPassNameField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Password Name",
        hintText: "Enter app name",
        errorText: _validatePassName ? "Please enter a app name" : null,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: appGreen2),
        ),
      ),
      controller: txtPassName,
    );
  }

  Widget buildUsernameField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "Enter a username",
        errorText: _validateUsername ? "Please enter a username" : null,
      ),
      controller: txtUsername,
    );
  }

  Widget buildPasswordField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter password",
        errorText: _validatePassword ? "Password can't be Empty !" : null,
      ),
      controller: txtPassword,
    );
  }

  void addPassword() async {
    setState(() {
      txtPassName.text.isEmpty
          ? _validatePassName = true
          : _validatePassName = false;
      txtUsername.text.isEmpty
          ? _validateUsername = true
          : _validateUsername = false;
      txtPassword.text.isEmpty
          ? _validatePassword = true
          : _validatePassword = false;
    });
    print(
        "AddPasword: textName: ${txtPassName.text},username: ${txtUsername.text} ,password: ${txtPassword.text}");
    if (_validatePassName == false &&
        _validateUsername == false &&
        _validatePassword == false) {
      var result = await dbHelper.insert(
          PassInfo(txtPassName.text, txtUsername.text, txtPassword.text));
      Navigator.pop(context, true);
    }
  }
}
