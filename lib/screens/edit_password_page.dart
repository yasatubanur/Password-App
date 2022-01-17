import 'package:flutter/material.dart';
import 'package:password_app/constants/constants.dart';
import 'package:password_app/data/db_helper.dart';
import 'package:password_app/models/pass_info.dart';

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

  @override
  void initState() {
    print("initState edit page");
    txtPassName.text = this.passInfo.passName!;
    txtUsername.text = this.passInfo.username!;
    txtPassword.text = this.passInfo.password!;
    print("end of init");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            color: Colors.white38,
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
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.transparent,
              ),
              onPressed: () {
                updatePassword();
              },
              child: Text(
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
          buildPassNameField(),
          buildUsernameField(),
          buildPasswordField(),
        ],
      ),
    );
  }

  Widget buildPassNameField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Password Name",
        hintText: "Please enter a app name",
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
        hintText: "Please enter a username",
      ),
      controller: txtUsername,
    );
  }

  Widget buildPasswordField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Please enter password",
      ),
      controller: txtPassword,
    );
  }

  void updatePassword() async {
    print(
        "updatePasword: textName: ${txtPassName.text},update username: ${txtUsername.text} ,password: ${txtPassword.text}");

    var result = await dbHelper.update(PassInfo.withId(
        passInfo.id, txtPassName.text, txtUsername.text, txtPassword.text));
    Navigator.pop(context, true);
  }
}
