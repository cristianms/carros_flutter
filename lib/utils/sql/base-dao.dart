import 'dart:async';

import 'package:carros/utils/sql/db-helper.dart';
import 'package:carros/utils/sql/entity.dart';
import 'package:sqflite/sqflite.dart';

/// Classe de acesso a dados - Data Access Object
abstract class BaseDAO<T extends Entity> {
  // Captura a instância do banco
  Future<Database> get db => DatabaseHelper.getInstance().db;

  // Propriedade que precisará ser setada ao utilizar o BaseDAO
  // representa a entidade
  String get tableName;

  T fromMap(Map<String, dynamic> map);

  // Método responsável por salvar o registro passado
  Future<int> save(T entity) async {
    // Captura instância do banco
    var dbClient = await db;
    // Insere na tabela da entidade o json (automático)
    // "conflictAlgorithm" significa que o banco irá ignorar registros duplicados
    // e não lançará erro nesse caso
    var id = await dbClient.insert(tableName, entity.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    print('id_inserido: $id');
    // Retorna o id inserido/alterado
    return id;
  }

  // Método responsável por buscar todos os registros da tabela da entidade do banco
  Future<List<T>> findAll() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select * from $tableName');
    return list.map<T>((json) => fromMap(json)).toList();
  }

  // Método responsável por buscar todos os registros de entidade POR ID
  Future<T> findById(int id) async {
    var dbClient = await db;
    final list = await dbClient.rawQuery('select * from $tableName where id = ?', [id]);
    if (list.length > 0) {
      return fromMap(list.first);
    }
    return null;
  }

  // Método responsável por verificar se um ID já existe no banco
  Future<bool> exists(int id) async {
    T c = await findById(id);
    var exists = c != null;
    return exists;
  }

  // Método responsável por contar quantos registros de carros há no banco
  Future<int> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select count(*) from $tableName');
    return Sqflite.firstIntValue(list);
  }

  // Método responsável por apagar um registro através do ID recebido
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from $tableName where id = ?', [id]);
  }

  // Método responsável por apagar todos os registros do banco
  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from $tableName');
  }
}
