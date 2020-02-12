import 'package:carros/pages/favoritos/entity.dart';

class Carro extends Entity {
  int id;
  String nome;
  String tipo;
  String descricao;
  String urlFoto;
  String urlVideo;
  String latitude;
  String longitude;

  Carro({
    this.id,
    this.nome,
    this.tipo,
    this.descricao,
    this.urlFoto,
    this.urlVideo,
    this.latitude,
    this.longitude,
  });

  Carro.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    tipo = map['tipo'];
    descricao = map['descricao'];
    urlFoto = map['urlFoto'];
    urlVideo = map['urlVideo'];
    latitude = map['latitude'];
    longitude = map['longitude'];
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = this.id;
    map['nome'] = this.nome;
    map['tipo'] = this.tipo;
    map['descricao'] = this.descricao;
    map['urlFoto'] = this.urlFoto;
    map['urlVideo'] = this.urlVideo;
    map['latitude'] = this.latitude;
    map['longitude'] = this.longitude;
    return map;
  }
}
