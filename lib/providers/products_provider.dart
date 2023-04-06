import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/category_model.dart';

import '../models/product_model.dart';
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<ProductModel> products = [];
  List<CategoryModel> categories = [];
  bool isLoading = false;


  addNewProduct(){}
initProducts(){
  getAllCategories();
  getAllProducts();
}
getAllCategories(){
  firestore.collection('categories').get().then((data) {
      for (var element in data.docs) {
        categories.add(CategoryModel.fromJson(element.data()));
      }
      notifyListeners();
    });
}

  getAllProducts() async {
    isLoading = true;
    notifyListeners();
    await firestore.collection('products').get().then((data) {
      products.clear();
      for (var element in data.docs) {
        products.add(ProductModel.fromJson(element.data()));
      }
      isLoading = false;
      notifyListeners();
    });
}

  getProductsByCatUID(String catUID) async {
    isLoading = true;
    notifyListeners();
    await firestore
        .collection('products')
        .where('category_uid', isEqualTo: catUID)
        .get()
        .then((data) {
      products.clear();
      for (var element in data.docs) {
        products.add(ProductModel.fromJson(element.data()));
      }
      isLoading = false;
      notifyListeners();
    });
  }


 
}