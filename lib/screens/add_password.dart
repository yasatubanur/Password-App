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
          backgroundColor: Color(0xff87986a),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Color(0xff87986a),
                backgroundColor: Colors.white60,
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
              const SizedBox(height: 10),
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

  Widget buildPasswordField() {
    return TextField(
      decoration: InputDecoration(labelText: "Password"),
      controller: txtPassword,
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
