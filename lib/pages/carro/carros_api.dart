import 'dart:convert';
import 'package:carros/pages/carro/carro.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  String tipo;
  static Future<List<Carro>> getCarros(String tipo) async {
    final carros = List<Carro>();

//    //Delay 2 segundos
//    await Future.delayed(Duration(seconds: 3));
//    //Lista temporária
//    carros.add(Carro(nome: "Chevrolet Impala Coupe", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Chevrolet_Impala_Coupe.png"));
//    carros.add(Carro(nome: "Ferrari FFF", urlFoto: "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png"));
//    carros.add(Carro(nome: "Porsche Panamera", urlFoto: "http://www.livroandroid.com.br/livro/carros/esportivos/Porsche_Panamera.png"));

    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/${tipo}';

      var response = await http.get(url);

      List list = jsonDecode(response.body);
      return list.map<Carro>((e) => Carro.fromJson(e)).toList();

    } catch(error) {

    }
  }
}