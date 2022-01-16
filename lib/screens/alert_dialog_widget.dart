import 'dart:ui';

import 'package:flutter/material.dart';

class BlurryDialog extends StatelessWidget {
  String title;
  String content;
  VoidCallback continueCallBack;

  BlurryDialog(this.title, this.content, this.continueCallBack);
  TextStyle textStyle = TextStyle(color: Colors.white60);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: AlertDialog(
          content: Text(
            content,
            style: textStyle,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Delete",
                style: textStyle,
              ),
              onPressed: () {
                continueCallBack();
              },
            ),
            TextButton(
              child: Text(
                "Cancel",
                style: textStyle,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
