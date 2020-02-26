import 'dart:async';

import 'package:carros/pages/carros/carro.dart';
import 'package:carros/utils/sql/base-dao.dart';

/// Classe de acesso a dados - Data Access Object
class CarroDAO extends BaseDAO<Carro> {

  // Seta propriedade tableName
  @override
  String get tableName => "carro";

  // Implementa método fromMap
  @override
  Carro fromMap(Map<String, dynamic> map) {
    return Carro.fromMap(map);
  }

  // Método responsável por buscar todos os registros de entidade POR TIPO
  Future<List<Carro>> findAllByTipo(String tipo) {
//    final dbClient = await db;
//    final list = await dbClient.rawQuery('select * from $tableName where tipo =? ',[tipo]);
//    return list.map<Carro>((json) => fromMap(json)).toList();
    return query('select * from $tableName where tipo =? ',[tipo]);
  }

}
