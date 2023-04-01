// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/consts.dart';
import '../helpers/functions_helper.dart';
import '../services/api.dart';
import '../widgets/dialogs/custom_flushbar_widget.dart';

enum Status { uninitialized, authenticated, authenticating, unauthenticated }

class AuthProvider with ChangeNotifier {
  final Api _api = Api();

  Status _status = Status.uninitialized;
  late String _token;

  Status get status => _status;
  String get token => _token;

  bool isLoading = false;

  initAuthProvider() async {
    String? token = await getToken();
    if (token != null) {
      _token = token;

      _status = Status.authenticated;
    } else {
      _status = Status.unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> register(Map body, BuildContext context) async {
    final response = await _api.post('/api/v1/register', body);

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('RESPONSE BODY SUCESS : ${response.body}');
      }

      Map apiResponse = json.decode(response.body);
      _status = Status.authenticated;
      _token = apiResponse['access_token'];
      await storeData('token', apiResponse['access_token']);
      notifyListeners();

      return true;
    } else {
      showCustomFlushbar(json.decode(response.body)['message'], warningColor,
          Icons.error, context);
      return false;
    }
  }

  Future<bool> login(Map<String, String> body, context) async {
    _status = Status.authenticating;
    isLoading = true;
    notifyListeners();

    if (kDebugMode) {
      print("LOGINBODY: $body");
    }

    final response = await _api.post('/api/v1/login', body);
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("LOGIN SUCCESS RESPONSE: ${response.body}");
      }
      Map apiResponse = json.decode(response.body);
      _status = Status.authenticated;
      _token = apiResponse['access_token'];
      await storeData('token', apiResponse['access_token']);
      notifyListeners();

      return true;
    } else {
      if (kDebugMode) {
        print("LOGIN FAILED RESPONSE: ${response.body}");
      }
    }

    if (response.statusCode == 401) {
      showCustomFlushbar('Invalid Password or Phone Number', warningColor,
          FontAwesomeIcons.circleInfo, context);
      _status = Status.unauthenticated;

      notifyListeners();
      return false;
    }

    _status = Status.unauthenticated;
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> registerFcm(
    Map body,
  ) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    final response = await _api.post('/user/fcm-token', {
      "fcm_token": fcmToken.toString(),
    });
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("FCM ✅");
        print("FCM TOKEN: $fcmToken");
      }
      // await FirebaseMessaging.instance.subscribeToTopic("test");
      // await FirebaseMessaging.instance.subscribeToTopic('news');
      return true;
    } else {
      if (kDebugMode) {
        print("FCM ❎");
      }

      return false;
    }
  }

  Future<bool> refreshToken() async {
    final response = await _api.refreshToken();

    if (response.first) {
      if (kDebugMode) {
        print("LOGIN SUCCESS RESPONSE: ${response.last.body}");
      }
      Map<String, dynamic> apiResponse = json.decode(response.last.body);
      _status = Status.authenticated;
      _token = apiResponse['access_token'];
      await storeData('token', apiResponse['aFccess_token']);
      notifyListeners();
      return true;
    } else {
      if (kDebugMode) {
        print("LOGIN FAILED RESPONSE: ${response.last.body}");
      }
      logOut();

      return false;
    }
  }

  Future<bool> changePassword(
      String oldPass, String newPass, BuildContext context) async {
    final response = await _api.post('/user/change-password',
        {"old_password": oldPass, "new_password": newPass});

    if (!json.decode(response.body)['message'].contains('incorrect')) {
      if (kDebugMode) {
        print("CHANGE PASSWORD SUCCESS RESPONSE: ${response.body}");
      }
      showCustomFlushbar(json.decode(response.body)['message'], mainColor,
          FontAwesomeIcons.check, context);
      return true;
    } else {
      if (kDebugMode) {
        print("CHANGE PASSWORD FAILED RESPONSE: ${response.body}");
      }
      showCustomFlushbar(json.decode(response.body)['message'], warningColor,
          FontAwesomeIcons.circleInfo, context);
      return false;
    }
  }

  Future<List> forgetPassword(Map body, BuildContext context) async {
    final response = await _api.post('/user/forgot-password', body);

    if (response.statusCode == 200) {
      return [true, json.decode(response.body)['message']];
    } else {
      return [false, json.decode(response.body)['message']];
    }
  }

  Future<bool> verifyForgetPassword(Map body, BuildContext context) async {
    final response = await _api.post('/user/forgot-password/verify', body);

    if (response.statusCode == 200) {
      showCustomFlushbar(json.decode(response.body)['message'], mainColor,
          Icons.check, context);
      return true;
    } else {
      showCustomFlushbar(json.decode(response.body)['message'], warningColor,
          Icons.error, context);
      return false;
    }
  }

  Future<bool> logOut() async {
    // final response = await _api.post('url here', {});
    // if (kDebugMode) {
    //   print(response.body);
    // }
    // _status = Status.unauthenticated;
    // SharedPreferences storage = await SharedPreferences.getInstance();
    // storage.clear();
    // notifyListeners();

    // storage.getKeys().forEach((key) {
    //   if (key != 'isDark') {
    //     storage.remove(key);
    //   }
    // });
    _status = Status.unauthenticated;
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.clear();
    return true;
  }

  Future<String?> getToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? token = storage.getString('token');
    return token;
  }

  setToken(String token) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString('token', token);
  }
}
