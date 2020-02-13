import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carros/carro_page.dart';
import 'package:carros/pages/carros/carros_bloc.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text-error.dart';
import 'package:flutter/material.dart';

import 'carro.dart';

// Declaração do statefull widget
class CarrosListView extends StatelessWidget {
  // Lista de carros
  List<Carro> carros;

  // Variável para controllar o brilho
  Brightness _brightness;

  // Construtor que recebe a lista de carros
  CarrosListView(this.carros);

  @override
  Widget build(BuildContext context) {
    _brightness = MediaQuery
        .of(context)
        .platformBrightness;
    // Observable que ficará olhando para uma resposta da lista
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: carros != null ? carros.length : 0,
          itemBuilder: (context, index) {
            Carro c = carros[index];
            return Card(
              color: _brightness == Brightness.dark ? Colors.grey[800] : Colors
                  .grey[300],
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: c.urlFoto,
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
                        onPressed: () => _onClickCarro(context, c),
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
              ),);
          }),
    );
  }

  _onClickCarro(BuildContext context, Carro c) {
    push(context, CarroPage(c));
  }
}
