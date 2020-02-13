import 'dart:convert';
import 'package:carros/pages/carros/carro.dart';
import 'package:carros/pages/favoritos/carro-dao.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  String tipo;

  static Future<List<Carro>> getCarros(String tipo) async {
    try {
      Usuario user = await Usuario.get();

      // Headers
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": "Bearer ${user.token}"
      };
      // URL da api de carros
      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/${tipo}';
      print('Fazendo requisição: $url');
      // Recebe o retorno da requisição
      var response = await http.get(url, headers: headers);
      String json = response.body;
      // Imprime o resultado
      print(json);
      // Decodifica o retorno json para um objeto List
      List list = jsonDecode(json);
      // Retorna o List
      List<Carro> carros = list.map<Carro>((e) => Carro.fromJson(e)).toList();

       // Salva carros da API no banco SQLite
       // final dao = CarroDAO();
       // carros.forEach(dao.save);

      return carros;
    } catch (error, exception) {
      print("$error > $exception");
      throw error;
    }
  }
}
