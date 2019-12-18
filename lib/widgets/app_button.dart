import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String label;
  Function onPressed;
  bool showProgress;

  AppButton(this.label, {this.onPressed, this.showProgress = false});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(15),
      child: showProgress
          ? Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ))
          : Text(
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
