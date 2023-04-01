import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/address_model.dart';
import '../services/api.dart';

class AddressesProvider with ChangeNotifier {
  Api api = Api();

  bool isLoading = true;
  bool isUpdating = false;
  bool isFailed = false;
  List<AddressModel> addresses = [];

  getAllAddresses() async {
    isLoading = true;
    notifyListeners();
    final response = await api.get('/client/address', {});

    if (response.statusCode == 200) {
      List<AddressModel> addressesData =
          (json.decode(response.body)['data'] as List)
              .map((data) => AddressModel.fromJson(data))
              .toList();
      setAddresses(addressesData);
    } else {
      isFailed = true;
      notifyListeners();
    }
  }

  setAddresses(List<AddressModel> addressesList) {
    addresses = addressesList;
    isLoading = false;
    isFailed = false;
    notifyListeners();
  }

  Future<List> addNewAddress(Map body) async {
    isLoading = true;
    notifyListeners();
    final response = await api.post('/client/address', body);

    if (response.statusCode == 201) {
      getAllAddresses();
      return [true, json.decode(response.body)['message']];
    } else {
      isFailed = true;
      notifyListeners();
      getAllAddresses();
      return [false, json.decode(response.body)['message']];
    }
  }

  Future<List> deleteAddress(int aId) async {
    isLoading = true;
    notifyListeners();
    final response = await api.delete('/client/address/$aId', {});

    if (response.statusCode == 200) {
      getAllAddresses();
      return [true, json.decode(response.body)['message']];
    } else {
      return [false, 'failed to delete address'];
    }
  }
}
