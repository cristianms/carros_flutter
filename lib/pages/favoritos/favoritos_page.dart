import 'package:carros/pages/carros/carro.dart';
import 'package:carros/pages/carros/carro_page.dart';
import 'package:carros/pages/carros/carros_bloc.dart';
import 'package:carros/pages/carros/carros_listview.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text-error.dart';
import 'package:flutter/material.dart';

import 'favoritos_bloc.dart';

/// Declaração do statefull widget
class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

// Classe do componente
class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {

  // Classe responsável pelas regras de negócio do componente
  final _bloc = new FavoritosBloc();
  // Funciona em conjunto com "AutomaticKeepAliveClientMixin" , avisa para manter a instancia do compoenente viva
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Chama a classe de negócio para buscar os dados da lista
    _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
    return _bloc.fetch();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
