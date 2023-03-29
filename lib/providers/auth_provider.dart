import 'dart:convert';

import '../services/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  unauthenticated,
}

class AuthProvider with ChangeNotifier {
  Api api = Api();

  Status _status = Status.uninitialized;
  String? _token;

  get status => _status;
  get token => _token;

  startProvider() async {
    _token = await getToken();

    if (_token != null) {
      _status = Status.authenticated;
    } else {
      _status = Status.unauthenticated;
    }
    notifyListeners();
  }

  login(Map body) async {
    var response = await api.post('/v1/client/auth/login', body);

    if (response.statusCode == 201) {
      var rawData = json.decode(response.body);
      setToken(rawData['token'].toString().trim());
      _status = Status.authenticated;
      notifyListeners();
    }
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    _status = Status.unauthenticated;
    notifyListeners();
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString('token');
    return tok;
  }

  setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}
