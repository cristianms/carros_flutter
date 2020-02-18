
import 'package:carros/pages/carros/carro-dao.dart';
import 'package:carros/pages/carros/carro.dart';
import 'package:carros/pages/favoritos/favorito-dao.dart';

import 'favorito.dart';

class FavoritoService {
  static favoritar(Carro c) async {
    Favorito f = Favorito.fromCarro(c);
    FavoritoDAO dao = new FavoritoDAO();

    bool existe = await dao.exists(c.id);
    if (existe) {
      dao.delete(f.id);
    } else {
      dao.save(f);
    }
  }
}