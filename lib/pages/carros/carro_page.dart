import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carros/carro-form-page.dart';
import 'package:carros/pages/carros/carro.dart';
import 'package:carros/pages/carros/carros_api.dart';
import 'package:carros/pages/carros/loripsum_api.dart';
import 'package:carros/pages/favoritos/favorito-service.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
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
  /// Cor do coraçãozinho
  Color color = Colors.grey;
  /// Carro recebido por parâmetro
  Carro get carro => widget.carro;

  @override
  void initState() {
    /// Chamada da API que irá buscar um texto lorem ipsum aleatório
    FavoritoService.isFavorito(carro).then((isFavorito) {
      setState(() {
        color = isFavorito ? Colors.red : Colors.grey;
      });
    });
    /// Chamada da API que irá buscar um texto lorem ipsum aleatório
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
        push(context, CarroFormPage(carro: carro));
        break;
      case "Deletar":
        deletar();
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
                imageUrl: widget.carro.urlFoto ?? "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png",
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
            IconButton(
                icon: Icon(
                    Icons.favorite,
                    color: color,
                    size: 40,
                ),
                onPressed: onClickFavorito
            ),
            IconButton(
                icon: Icon(Icons.share),
                onPressed: onClickShare
            ),
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

  void onClickFavorito() async {
    bool favoritado = await FavoritoService.favoritar(carro);
    setState(() {
      color = favoritado ? Colors.red : Colors.grey;
    });
  }

  void onClickShare() {}

  void deletar() async {
    ApiResponse<bool> response = await CarrosApi.delete(carro);
    if (response.ok) {
      alert(context, "Carro deletado com sucesso", callback: () {
        pop(context);
      });
    } else {
      alert(context, response.msg);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _loripsumApiBloc.dispose();
  }
}
