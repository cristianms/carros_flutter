import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String label;
  Function onPressed;

  AppButton(this.label, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(15),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
      ),
      color: Colors.blue,
      onPressed: onPressed,
    );
  }
}
