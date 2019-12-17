import 'package:carros/pages/home_page.dart';
import 'package:carros/pages/login_api.dart';
import 'package:carros/pages/usuario.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formkey = GlobalKey<FormState>();
  final tLogin = TextEditingController();
  final tSenha = TextEditingController();
  final _focusSenha = FocusNode();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formkey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
                "Login",
                "Digite o login",
                controller: tLogin,
                validator: _validateLogin,
                keyboardType: TextInputType.emailAddress,
                action: TextInputAction.next,
                nextFocus: _focusSenha
            ),
            SizedBox(height: 10),
            AppText(
                "Senha",
                "Digite a senha",
                controller: tSenha,
                password: true,
                validator: _validateSenha,
                keyboardType: TextInputType.number,
                action: TextInputAction.done,
                focusNode: _focusSenha
            ),
            SizedBox(height: 20),
            AppButton("Login", onPressed: _onClickLogin,),
          ],
        ),
      ),
    );
  }

  Future _onClickLogin() async {
    String login = tLogin.text;
    String senha = tSenha.text;

    bool formOk = _formkey.currentState.validate();
    if (!formOk) {
      return;
    }
    Usuario usuario = await LoginApi.login(login, senha);
    if(usuario != null) {
      print(usuario.toString());
      push(context, HomePage());
    } else {
      print("Login incorreto...");
    }
  }

  String _validateLogin(String value) {
    if (value.isEmpty) {
      return "Digite o texto";
    }
    return null;
  }

  String _validateSenha(String value) {
    if (value.isEmpty) {
      return "Digite o texto";
    }
    if (value.length <= 2) {
      return "A senha deve conter mais de 2 dígitos. Verifique";
    }
    return null;
  }
}