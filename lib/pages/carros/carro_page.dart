import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carros/carro.dart';
import 'package:carros/pages/carros/loripsum_api.dart';
import 'package:carros/pages/favoritos/favorito-service.dart';
import 'package:carros/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsumApiBloc = LoripsumBloc();

  Carro get carro => widget.carro;

  @override
  void initState() {
    _loripsumApiBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
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
                PopupMenuItem(
                  value: "Editar",
                  child: Text("Editar"),
                ),
                PopupMenuItem(
                  value: "Deletar",
                  child: Text("Deletar"),
                ),
                PopupMenuItem(
                  value: "Compartilhar",
                  child: Text("Compartilhar"),
                ),
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
        child: ListView(
          children: <Widget>[
            CachedNetworkImage(
                imageUrl: widget.carro.urlFoto
            ),
            _bloco1(),
            Divider(),
            _bloco2(),
          ],
        ));
  }

  Row _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text(widget.carro.nome, fontSize: 20, bold: true),
            text(widget.carro.tipo, fontSize: 16),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.favorite), onPressed: onClickFavorito),
            IconButton(icon: Icon(Icons.share), onPressed: onClickShare),
          ],
        ),
      ],
    );
  }

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20,),
        text(widget.carro.descricao, fontSize: 16),
        SizedBox(height: 20,),
        StreamBuilder<String>(
          stream: _loripsumApiBloc.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return text(snapshot.data, fontSize: 16);
          },
        ),
      ],
    );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  void onClickFavorito() {
    FavoritoService.favoritar(carro);
  }

  void onClickShare() {}

  @override
  void dispose() {
    super.dispose();
    _loripsumApiBloc.dispose();
  }
}
