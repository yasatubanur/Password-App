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
  var txtPassName = TextEditingController();
  var txtUsername = TextEditingController();
  var txtPassword = TextEditingController();
  var dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Add Password",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: appGreen,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
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
        hintText: "Password App",
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
        hintText: "yasatuba",
      ),
      controller: txtUsername,
    );
  }

  Widget buildPasswordField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "12345",
      ),
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
