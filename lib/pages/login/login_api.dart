import 'dart:convert';
import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      // URL da API
      var url = 'https://carros-springboot.herokuapp.com/api/v2/login';
      // Headers
      Map<String, String> headers = {'Content-type': 'application/json'};
      // Parâmetros
      Map params = {
        'username': login,
        'password': senha,
      };
      // Converte parâmetros para JSON para fazer a requisição
      String jsonParams = json.encode(params);
      // Captura resposta
      var response = await http.post(url, body: jsonParams, headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      // Tranforma resposta em um objeto map
      Map mapResponse = json.decode(response.body);
      //String nome = mapResponse['nome'];
      //String email = mapResponse['email'];
      // Se a requisição foi bem sucedida
      if (response.statusCode == 200) {
        // Converte o usuário recebido para um objeto Usuario
        final user = Usuario.fromJson(mapResponse);
        // Salva os dados do usuário em SharedPreferences
        user.save();
        // Retorna código de sucesso
        return ApiResponse.ok(user);
      }
      // Retorna código de erro
      return ApiResponse.error(mapResponse['error']);
    } catch(error, exception) {
      print("Erro no login: $error > $exception");
      return ApiResponse.error("Não foi possível fazer login");
    }
  }
}
