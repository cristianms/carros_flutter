import 'dart:async';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Declara a variável "_instance" como "static final" para que ela seja
  // acessada diretamente e para garantir que ela seja única na aplicação
  static final DatabaseHelper _instance = DatabaseHelper.getInstance();

  // Isso é um named constructor irá chamar o construtor da classe
  DatabaseHelper.getInstance();

  // Contrutor que será acessado quando for solicitada uma instancia do db
  // sempre será retornada a instância que já está aberta (singleton)
  factory DatabaseHelper() => _instance;

  // Variável responsável por guardar a instância de db
  static Database _db;

  Future<Database> get db async {
    // Se a variável _db NÃO for nula
    if (_db != null) {
      // Retorna a instância existente
      return _db;
    }
    // Se for nula significa que é a primeira solicitação de db então chama
    // função que inicia a conexão, e coloca em _db (dessa forma em solicitações
    // futuras a conexão já estará aqui dentro de _db)
    _db = await _initDb();
    // Retorna a conexão
    return _db;
  }

  // Função responsável por retorna uma instância do banco de dados
  Future _initDb() async {
    // Caminho do diretório do arquivo de banco de dados
    String databasesPath = await getDatabasesPath();
    // Caminho do diretório do arquivo de banco de dados com o nome do arquivo
    // padrão (que é o nome do projeto)
    String path = join(databasesPath, 'carros.db');
    // Imprime o caminho
    print("db $path");
    // Abre conexão, fazendo os upgrade de versão necessários, nesse caso está
    // na versão 2, o controle é feito no método "_onUpgrade"
    var db = await openDatabase(
        path, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    // Retorna instância
    return db;
  }

  // Método que cria o banco inicial
  void _onCreate(Database db, int newVersion) async {
    // Lê conteúdo de arquivo SQL na pasta assets
    String sqlCreate = await rootBundle.loadString('assets/sql/create.sql');
    // Separa blocos por ";"
    List<String> sqls = sqlCreate.split(';');
    // Um por um
    for (String sql in sqls) {
      if (sql.trim().isNotEmpty) {
        // Executa SQL
        await db.execute(sql);
      }
    }
  }

  // Método que controla as versões do banco e roda os upgrade necessários de
  // acordo com a versão do ap´p do usuário
  Future<FutureOr<void>> _onUpgrade(Database db, int oldVersion,
      int newVersion) async {
    print("_onUpgrade: oldVersion: $oldVersion > newVersion: $newVersion");

    if (oldVersion == 1 && newVersion == 2) {
      await db.execute("alter table carro add column NOVA TEXT");
    }
  }

  // Chama para encerrar a conexão
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
