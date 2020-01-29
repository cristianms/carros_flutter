import 'dart:async';

import 'package:carros/utils/simple_bloc.dart';

import 'carro.dart';
import 'carros_api.dart';

class CarrosBloc extends SimpleBloc<List<Carro>> {

  Future<List<Carro>> fetch(String tipo) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo);
      add(carros);
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