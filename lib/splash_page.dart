import 'package:carros/pages/carros/home_page.dart';
import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/utils/sql/db-helper.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // Inicializa o banco de dados do app
    Future futureA = DatabaseHelper
        .getInstance()
        .db;
    // Delay de 3 segundos
    Future futureB = Future.delayed(Duration(seconds: 3));
    // Future que verifica se há usuário logado
    Future<Usuario> futureC = Usuario.get();
    // Quando todas as future terminarem faz a validação
    Future.wait([futureA, futureB, futureC]).then((List values) {
      Usuario user = values[2];
      // Se existe usuário logado
      if (user != null) {
        // Direciona para a HomePage
        push(context, HomePage(), replace: true);
      } else {
        // Direciona para a LoginPage
        push(context, LoginPage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
