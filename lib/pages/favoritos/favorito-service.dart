import 'package:carros/pages/carros/carro-dao.dart';
import 'package:carros/pages/carros/carro.dart';
import 'package:carros/pages/favoritos/favorito-dao.dart';

import 'favorito.dart';

/// Service para tratar as regras de negócio e requisições relacionadas a Favoritos
class FavoritoService {

  /// Método responsável por favoritar um carro
  static Future<bool> favoritar(Carro c) async {
    /// Instancia um objeto Favorito através de uma instância de Carro
    Favorito f = Favorito.fromCarro(c);

    /// Instancia um objeto DAO para persistir o objeto Favorito
    FavoritoDAO dao = new FavoritoDAO();

    /// Verifica se o registro já existe no banco de dados
    bool existe = await dao.exists(c.id);
    if (existe) {
      /// Se existir remove
      dao.delete(f.id);
      return false;
    } else {
      /// Se não existir, insere
      dao.save(f);
      return true;
    }
  }

  /// Método responsável por listar os carros marcados como Favorito
  static Future<List<Carro>> getCarros() async {
    List<Carro> carros = await CarroDAO().query(
        "SELECT * FROM carro c, favorito f WHERE c.id = f.id");
    return carros;
  }

  /// Método responsável por responder se o carro é um favorito
  /// Método responsável por favoritar um carro
  static Future<bool> isFavorito(Carro c) async {
    /// Instancia um objeto DAO para persistir o objeto Favorito
    FavoritoDAO dao = new FavoritoDAO();
    /// Verifica se o registro já existe no banco de dados
    bool existe = await dao.exists(c.id);
    return existe;
  }
}