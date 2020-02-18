
import 'package:carros/pages/carros/carro.dart';
import 'package:carros/utils/sql/entity.dart';

class Favorito extends Entity {

  int id;
  String nome;

  Favorito({
    this.id,
    this.nome,
  });

  /// Named constructor para receber um map e montar o objeto com base no map recebido
  Favorito.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
  }

  /// Named constructor para receber um carro e montar o objeto com base no carro recebido
  Favorito.fromCarro(Carro carro) {
    id = carro.id;
    nome = carro.nome;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = this.id;
    map['nome'] = this.nome;
    return map;
  }

}