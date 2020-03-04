import 'dart:async';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;

/// Método responsável por centralizar as requisições do tipo GET
Future<http.Response> get(String url) async {
  final headers = await _headers();
  var response = await http.get(url, headers: headers);
  return response;
}

/// Método responsável por centralizar as requisições do tipo POST
Future<http.Response> post(String url, {body}) async {
  final headers = await _headers();
  var response = await http.post(url, headers: headers, body: body);
  return response;
}

/// Método responsável por centralizar as requisições do tipo PUT
Future<http.Response> put(String url, {body}) async {
  final headers = await _headers();
  var response = await http.put(url, headers: headers, body: body);
  return response;
}

/// Método responsável por centralizar as requisições do tipo DELETE
Future<http.Response> delete(String url) async {
  final headers = await _headers();
  var response = await http.put(url, headers: headers);
  return response;
}

/// Método responsável por montar o header para as requisições
Future<Map<String, String>> _headers() async {
  Usuario usuario = await Usuario.get();
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer ${usuario.token}"
  };
  return headers;
}
