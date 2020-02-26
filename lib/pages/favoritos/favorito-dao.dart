import 'dart:async';

import 'package:carros/utils/sql/base-dao.dart';
import 'package:carros/pages/favoritos/favorito.dart';

/// Classe de acesso a dados - Data Access Object
class FavoritoDAO extends BaseDAO<Favorito> {

  // Seta propriedade tableName
  @override
  String get tableName => "favorito";

  // Implementa método fromMap
  @override
  Favorito fromMap(Map<String, dynamic> map) {
    return Favorito.fromMap(map);
  }

}
