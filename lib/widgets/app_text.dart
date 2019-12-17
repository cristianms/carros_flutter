import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String label;
  String hint;
  TextEditingController controller;
  bool password;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  TextInputAction action;
  FocusNode focusNode;
  FocusNode nextFocus;

  AppText(this.label, this.hint,
      {this.controller, this.password = false, this.validator,
        this.keyboardType, this.action, this.focusNode, this.nextFocus});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: password,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: action,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      style: TextStyle(
        fontSize: 25,
        color: Colors.blue,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
          labelStyle: TextStyle(
            fontSize: 25,
            color: Colors.grey,
          ),
          labelText: label,
          hintText: hint
      ),
    );
  }
}
