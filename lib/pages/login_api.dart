import 'dart:convert';
import 'package:carros/pages/usuario.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<Usuario> login(String login, String senha) async {
    var url = 'https://carros-springboot.herokuapp.com/api/v2/login';
    Map<String, String> headers = {
      'Content-type': 'application/json'
    };
    Map params = {
      'username': login,
      'password': senha,
    };

    String jsonParams = json.encode(params);

    var response = await http.post(url, body: jsonParams, headers: headers);
//    print('Response status: ${response.statusCode}');
//    print('Response body: ${response.body}');

    Map mapResponse = json.decode(response.body);
//    String nome = mapResponse['nome'];
//    String email = mapResponse['email'];

    final usuario = Usuario.fromJson(mapResponse);

    return usuario;
  }
}