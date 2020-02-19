import 'dart:async';

import 'package:carros/pages/carros/carro-dao.dart';
import 'package:carros/pages/carros/carro.dart';
import 'package:carros/pages/favoritos/favorito-service.dart';
import 'package:carros/utils/simple_bloc.dart';


/// Classe Bloc criada para tratar regras e requisições de 'carros'
class FavoritosBloc extends SimpleBloc<List<Carro>> {
  /// Método responsável por retornar um List de carros
  Future<List<Carro>> fetch() async {
    try {
      // Se tiver internet busca diretamente na API
      List<Carro> carros = await FavoritoService.getCarros();
      // Popula SQLite com os carros da API
      if (carros.isNotEmpty) {
        // Salva carros da API no banco SQLite
        final dao = CarroDAO();
        carros.forEach(dao.save);
      }
      // Adiciona dados para o stream
      add(carros);
      // Retorna
      return carros;
    } catch (e) {
      print(e);
      addError(e);
    }
  }

//  void dispose() {
//    _streamController.close();
//  }

}