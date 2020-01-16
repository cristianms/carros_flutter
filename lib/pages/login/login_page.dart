import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/alert.dart';
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
  var _showProgress = false;

  @override
  void initState() {
    super.initState();
    // Ao iniciar a tela de login verificar se existe usuário logado
    Future<Usuario> future = Usuario.get();
    future.then((Usuario user) {
      setState(() {
        // Se existe usuário logado
        if (user != null) {
          // Direciona para a HomePage
          push(context, HomePage(), replace: true);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    tLogin.text = "user";
    tSenha.text = "123";

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
              nextFocus: _focusSenha,
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
              focusNode: _focusSenha,
            ),
            SizedBox(height: 20),
            AppButton(
              "Login",
              onPressed: _onClickLogin,
              showProgress: _showProgress,
            ),
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

    setState(() {
      _showProgress = true;
    });

    ApiResponse response = await LoginApi.login(login, senha);
    if (response.ok) {
      Usuario usuario = response.result;
      //print(usuario.toString());
      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.msg);
    }

    setState(() {
      _showProgress = false;
    });
  }

  String _validateLogin(String value) {
    if (value.isEmpty) {
      return "Digite o texto";
    }
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
