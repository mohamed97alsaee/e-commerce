import 'package:e_commerce/helpers/consts.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Api {
  get(String url, Map body) async {
    var response = await http.get(Uri.parse(baseUrl + url));
    if (kDebugMode) {
      print('GET ON : $baseUrl$url \n with body: $body');

      print('Status code: ${response.statusCode} response: ${response.body}');
    }
    return response;
  }

  Future<http.Response> post(String url, Map body) async {
    var response = await http.post(Uri.parse(baseUrl + url), body: body);
    if (kDebugMode) {
      print('POST ON : $baseUrl$url \n with body: $body');
      print('Status code: ${response.statusCode} response: ${response.body}');
    }
    return response;
  }

  put(String url, Map body) async {
    var response = await http.put(Uri.parse(baseUrl + url), body: body);
    if (kDebugMode) {
      print('PUT ON : $baseUrl$url \n with body: $body');
      print('Status code: ${response.statusCode} response: ${response.body}');
    }
    return response;
  }

  delete(String url, Map body) async {
    var response = await http.delete(Uri.parse(baseUrl + url), body: body);
    if (kDebugMode) {
      print('DELETE ON : $baseUrl$url \n with body: $body');
      print('Status code: ${response.statusCode} response: ${response.body}');
    }
    return response;
  }
}
