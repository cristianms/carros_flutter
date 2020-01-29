import 'dart:async';

import 'package:carros/pages/carros/carro.dart';
import 'package:carros/pages/favoritos/db-helper.dart';
import 'package:sqflite/sqflite.dart';

// Data Access Object
class CarroDAO {
  // Captura a instância do banco
  Future<Database> get db => DatabaseHelper.getInstance().db;

  // Método responsável por salvar o carro passado
  Future<int> save(Carro carro) async {
    // Captura instância do banco
    var dbClient = await db;
    // Insere na tabela "carro" o json (autoático)
    // "conflictAlgorithm" significa que o banco irá ignorar registros duplicados
    // e não lançará erro nesse caso
    var id = await dbClient.insert("carro", carro.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    print('id: $id');
    // Retorna o id inserido/alterado
    return id;
  }

  // Método responsável por buscar todos os registros de carros do banco
  Future<List<Carro>> findAll() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select * from carro');
    final carros = list.map<Carro>((json) => Carro.fromJson(json)).toList();
    return carros;
  }

  // Método responsável por buscar todos os registros de carros POR TIPO
  Future<List<Carro>> findAllByTipo(String tipo) async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select * from carro where tipo =? ',[tipo]);
    final carros = list.map<Carro>((json) => Carro.fromJson(json)).toList();
    return carros;
  }

  // Método responsável por buscar todos os registros de carros POR ID
  Future<Carro> findById(int id) async {
    var dbClient = await db;
    final list = await dbClient.rawQuery('select * from carro where id = ?', [id]);
    if (list.length > 0) {
      return new Carro.fromJson(list.first);
    }
    return null;
  }

  // Método responsável por verificar se um ID já existe no banco
  Future<bool> exists(Carro carro) async {
    Carro c = await findById(carro.id);
    var exists = c != null;
    return exists;
  }

  // Método responsável por contar quantos registros de carros há no banco
  Future<int> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select count(*) from carro');
    return Sqflite.firstIntValue(list);
  }

  // Método responsável por apagar um registro através do ID recebido
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from carro where id = ?', [id]);
  }

  // Método responsável por apagar todos os registros do banco
  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from carro');
  }
}
