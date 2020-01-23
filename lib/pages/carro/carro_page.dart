import 'package:carros/pages/carro/carro.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatelessWidget {

  Carro carro;

  CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo,
          ),
          PopupMenuButton<String>(
            onSelected: _onClickPopupMenu,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: "Editar", child: Text("Editar"),),
                PopupMenuItem(value: "Deletar", child: Text("Deletar"),),
                PopupMenuItem(
                  value: "Compartilhar", child: Text("Compartilhar"),),
              ];
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  void _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        print(value);
        break;
      case "Deletar":
        print(value);
        break;
      case "Compartilhar":
        print(value);
        break;
    }
  }

  _body() {
    return Container(
        padding: EdgeInsets.all(16),
        child: Image.network(carro.urlFoto)
    );
  }

  void _onClickMapa() {
  }

  void _onClickVideo() {
  }
}
