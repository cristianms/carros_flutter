import 'package:carros/pages/carros/carro_page.dart';
import 'package:carros/pages/carros/carros_bloc.dart';
import 'package:carros/pages/carros/carros_listview.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text-error.dart';
import 'package:flutter/material.dart';

import 'carro.dart';

// Declaração do statefull widget
class CarrosPage extends StatefulWidget {
  // Define o tipo de carro a ser carregado
  String tipo;

  // Inicia a classe passando o parâmetro do tipo de carro
  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

// Classe do componente
class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  // Lista de carros
  List<Carro> carros;

  // Classe responsável pelas regras de negócio do componente
  CarrosBloc _bloc = new CarrosBloc();

  // Funciona em conjunto com "AutomaticKeepAliveClientMixin" , avisa para manter a instancia do compoenente viva
  bool get wantKeepAlive => true;
  Brightness _brightness;

  // Tipo de carro
  String get tipo => widget.tipo;

  @override
  void initState() {
    super.initState();
    // chama a classe de negócio para buscar os dados da lista
    print('tipo: ' + tipo);
    _bloc.fetch(tipo);

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    _brightness = MediaQuery.of(context).platformBrightness;

    // Observable que ficará olhando para uma resposta da lista
    return StreamBuilder(
      stream: _bloc.stream, // Saída da resposta
      builder: (context, snapshot) {
        // Regras que serão executadas após receber o retorno
        // Se a requisição falhar exibe mensagem
        if (snapshot.hasError) {
          return TextError("Não foi possível buscar os carros...");
        }
        // Enquanto os dados não vem habilita o "loader circular"
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // Recebe a lista de carros
        List<Carro> carros = snapshot.data;
        // Retorna o componente listview com os dados
        return RefreshIndicator(
            onRefresh: _onRefresh,
            child: CarrosListView(carros),
        );
      },
    );
  }

  _onClickCarro(Carro c) {
    push(context, CarroPage(c));
  }

  Future<void> _onRefresh() {
    return _bloc.fetch(tipo);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
