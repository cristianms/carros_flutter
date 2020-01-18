import 'dart:async';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/login_bloc.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';

// Declaração de statefull widget
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

// Declaração da classe princiál do componente
class _LoginPageState extends State<LoginPage> {
  // Chave para controlle do formulário
  var _formkey = GlobalKey<FormState>();
  // Campo login
  final tLogin = TextEditingController();
  // Campo senha
  final tSenha = TextEditingController();
  // Define foco no campo senha
  final _focusSenha = FocusNode();
  // Bloc
  final _bloc = LoginBloc();

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
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            StreamBuilder<bool>(
              stream: _bloc.stream,
              initialData: false,
              builder: (context, snapshot) {
                return AppButton(
                  "Login",
                  onPressed: _onClickLogin,
                  showProgress: snapshot.data,
                );
              }
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

    ApiResponse response = await _bloc.login(login, senha);
    if (response.ok) {
      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.msg);
    }
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
