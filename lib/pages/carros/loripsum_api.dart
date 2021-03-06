import 'dart:async';

import 'package:http/http.dart' as http;

class LoripsumBloc {

  static String lorimCache;

  final _streamController = StreamController<String>();

  Stream<String> get stream => _streamController.stream;

  fetch() async {
    String s = lorimCache ?? await LoripsumApi.getLoripsum();
    lorimCache = s;
    _streamController.add(s);
  }

  void dispose() {
    _streamController.close();
  }
}

class LoripsumApi {
  static Future<String> getLoripsum() async {
    var url = 'https://loripsum.net/api';

    print('GET > $url');

    var response = await http.get(url);

    String text = response.body;

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");

    return text;
  }
}