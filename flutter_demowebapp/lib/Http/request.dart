import 'package:http/http.dart' as http;
import 'package:flutter_demowebapp/Http/url.dart';

class Request {
  final String url;
  final dynamic body;

  Request({this.url, this.body});

  Future<http.Response> post() {
    var parseUrl = Uri.parse(urlBase + this.url);
    return http.post(parseUrl, body: body).timeout(Duration(minutes: 2));
  }
  Future<http.Response> get() {
    var parseUrl = Uri.parse(urlBase + this.url);
    return http.get(parseUrl).timeout(Duration(minutes: 2));
  }
}