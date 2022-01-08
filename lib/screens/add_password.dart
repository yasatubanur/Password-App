import 'package:flutter/material.dart';
import 'package:password_app/data/db_helper.dart';
import 'package:password_app/models/pass_info.dart';

class AddPassword extends StatefulWidget {
  const AddPassword({Key? key}) : super(key: key);

  @override
  _AddPasswordState createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {
  var txtPassName = TextEditingController();
  var txtUsername = TextEditingController();
  var txtPassword = TextEditingController();
  var dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Password"),
          backgroundColor: Color(0xb58ecae6),
        ),
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              buildPassNameField(),
              buildUsernameField(),
              buildPasswordField(),
              buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  TextField buildPassNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Password Name"),
      controller: txtPassName,
    );
  }

  Widget buildUsernameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Username"),
      controller: txtUsername,
    );
  }

  TextField buildPasswordField() {
    return TextField(
      decoration: InputDecoration(labelText: "Password"),
      controller: txtPassword,
    );
  }

  buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: TextButton(
        onPressed: () {
          addPassword();
        },
        child: Text("Save"),
      ),
    );
  }

  void addPassword() async {
    print(
        "AddPasword: textName: ${txtPassName.text},username: ${txtUsername.text} ,password: ${txtPassword.text}");
    var result = await dbHelper
        .insert(PassInfo(txtPassName.text, txtUsername.text, txtPassword.text));
    Navigator.pop(context, true);
  }
}
