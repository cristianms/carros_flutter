import 'dart:convert';
import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v2/login';
      Map<String, String> headers = {'Content-type': 'application/json'};
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

      if (response.statusCode == 200) {
        final usuario = Usuario.fromJson(mapResponse);
        return ApiResponse.ok(usuario);
      }

      return ApiResponse.error(mapResponse['error']);
    } catch(error, exception) {
      print("Erro no login: $error > $exception");
      return ApiResponse.error("Não foi possível fazer login");
    }
  }
}
