import 'dart:async';

import 'package:carros/pages/carros/carro-dao.dart';
import 'package:carros/utils/network.dart';
import 'package:carros/utils/simple_bloc.dart';

import 'carro.dart';
import 'carros_api.dart';

/// Classe Bloc criada para tratar regras e requisições de 'carros'
class CarrosBloc extends SimpleBloc<List<Carro>> {
  /// Método responsável por retornar um List de carros
  Future<List<Carro>> fetch(String tipo) async {
    try {
      // Verificação de conectividade
      bool networkOn = await isNetworkOn();
      // Se NÃO existir internet/rede
      if (!networkOn) {
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        // Adiciona dados para o stream
        add(carros);
        // Retorna
        return carros;
      }
      // Se tiver internet busca diretamente na API
      List<Carro> carros = await CarrosApi.getCarros(tipo);
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