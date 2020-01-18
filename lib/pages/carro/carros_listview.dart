import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/pages/carro/carros_bloc.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

import 'carro.dart';

// Declaração do statefull widget
class CarrosListView extends StatefulWidget {
  // Define o tipo de carro a ser carregado
  String tipo;

  // Inicia a classe passando o parâmetro do tipo de carro
  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

// Classe do componente
class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  // Lista de carros
  List<Carro> carros;

  // Classe responsável pelas regras de negócio do componente
  CarrosBloc _bloc = new CarrosBloc();

  // Funciona em conjunto com "AutomaticKeepAliveClientMixin" , avisa para manter a instancia do compoenente viva
  bool get wantKeepAlive => true;

  // Tipo de carro
  String get tipo => widget.tipo;

  @override
  void initState() {
    super.initState();
    // chama a classe de negócio para buscar os dados da lista
    _bloc.fetch(tipo);
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
          return Center(
            child: Text(
              "Não foi possível bscar os carros",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 22
              ),
            ),
          );
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
        return _listView(carros);
      },
    );
  }

  // Compoenente responsável por exibir a lista de carros
  Container _listView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: carros != null ? carros.length : 0,
          itemBuilder: (context, index) {
            Carro c = carros[index];
            return Card(
              color: Colors.grey[200],
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.network(
                        c.urlFoto ??
                            "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwiIqMaH2MDmAhU6ELkGHZ2PB4EQjRx6BAgBEAQ&url=https%3A%2F%2Fwww.shutterstock.com%2Fsearch%2Fno%2Bpicture%2Bavailable%3Fimage_type%3Dillustration&psig=AOvVaw0OfG7cmU7xQYe_6V4zoXT9&ust=1576809702362213",
                        width: 250,
                      ),
                    ),
                    Text(
                      c.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      "Descrição ...",
                      style: TextStyle(fontSize: 16),
                    ),
                    ButtonBar(children: <Widget>[
                      FlatButton(
                        child: const Text('DETALHES'),
                        onPressed: () => _onClickCarro(c),
                      ),
                      FlatButton(
                        child: const Text('COMPARTILHAR'),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                    ]),
                  ],
                ),
              ),
            );
          }),
    );
  }

  _onClickCarro(Carro c) {
    push(context, CarroPage(c));
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
