import 'package:carros/pages/login/login_page.dart';
import 'package:carros/splash_page.dart';
import 'package:flutter/material.dart';

// Entrada ao app, método que inicia o app como um todo
void main() => runApp(MyApp());

// Classe responsável por dar andamento a tela inicial do app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashPage(),
    );
  }
}