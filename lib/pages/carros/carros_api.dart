import 'dart:convert';
import 'package:carros/pages/carros/carro.dart';
import 'package:carros/pages/carros/carro-dao.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../api_response.dart';

/// Definição dos tipos de carros
class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

/// Classe responsável por realizar as requisições relacionadas a entidade carro
class CarrosApi {
  // Tipo do carro
  String tipo;

  // Método responsável por busar os carros no servidor
  static Future<List<Carro>> getCarros(String tipo) async {
    try {
      Usuario user = await Usuario.get();

      // Monta os headers da requisição, necessário obter e repassar o token
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": "Bearer ${user.token}"
      };
      // URL da api de carros
      var url =
          'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/${tipo}';
      print('Fazendo requisição: $url');
      // Recebe o retorno da requisição
      var response = await http.get(url, headers: headers);
      String json = response.body;
      // Imprime o resultado
      print(json);
      // Decodifica o retorno json para um objeto List
      List list = jsonDecode(json);
      // Retorna o List
      List<Carro> carros = list.map<Carro>((e) => Carro.fromMap(e)).toList();
      return carros;
    } catch (error, exception) {
      print("$error > $exception");
      throw error;
    }
  }

  static Future<ApiResponse<bool>> save(Carro c) async {
    try {
      // Busca o usuário logado
      Usuario user = await Usuario.get();
      // Monta headers da requisição
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.token}"
      };
      // URL
      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros';
      if (c.id != null) {
        url += '/${c.id}';
      }

      print('POST/PUT > $url');
      String json = c.toJson();
      // Resposta
      var resposta = await (c.id == null
          ? http.post(url, headers: headers, body: json)
          : http.put(url, headers: headers, body: json));
      print('Response status: ${resposta.statusCode}');
      print('Response body: ${resposta.body}');
      if (resposta.statusCode == 200 || resposta.statusCode == 201) {
        Map mapResposta = convert.json.decode(resposta.body);
        Carro carro = Carro.fromMap(mapResposta);
        print('Novo carro: ${carro.id}');
        return ApiResponse.ok(true);
      }

      if (resposta.body == null || resposta.body.isEmpty) {
        return ApiResponse.error('Não foi possível salvar o carro');
      }

      Map mapResposta = convert.json.decode(resposta.body);
      return ApiResponse.error(mapResposta['error']);
    } catch (erro) {
      print(erro);
      return ApiResponse.error('Não foi possível salvar o carro');
    }
  }

  static Future<ApiResponse<bool>> delete(Carro c) async {
    try {
      // Busca o usuário logado
      Usuario user = await Usuario.get();
      // Monta headers da requisição
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.token}"
      };
      // URL
      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/${c.id}';

      var response = await http.delete(url, headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        print('${c.id} excluido');
        return ApiResponse.ok(true);
      }
      return ApiResponse.error("Não foi possível deletar o carro");
    } catch (e) {
      print(e);
      return ApiResponse.error("Não foi possível deletar o carro");
    }
  }
}
