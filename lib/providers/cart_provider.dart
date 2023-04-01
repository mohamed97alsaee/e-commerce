// import 'dart:convert';
// import 'package:babak/models/cart_item_model.dart';
// import 'package:flutter/foundation.dart';
// import '../services/api.dart';
// class CartProvider with ChangeNotifier {
//   Api api = Api();
//   bool isLoading = true;
//   bool isUpdating = false;
//   bool isFailed = false;
//   bool isAdding = false;
//   List<CartItemModel> cartItems = [];
//   double cartTotal = 0;
//   String vendorName = '';
//   int? vendorId;
//   initCartProvider() {
//     getCartItems();
//   }
//   getCartItems() async {
//     isLoading = true;
//     notifyListeners();
//     final response = await api.get('/client/cart', {});
//     if (response.statusCode == 200) {
//       // cartItemsData = (json.decode(response.body)['data']['items'] as List)
//       // .map((data) => CartItemModel.fromJson(data))
//       // .toList();
//       List<CartItemModel> cartItemsData =
//           (json.decode(response.body)['data']['items'] as List)
//               .map((data) => CartItemModel.fromJson(data))
//               .toList();
//       setCartItems(
//           cartItemsData,
//           double.parse(json.decode(response.body)['data']['total'].toString()),
//           json.decode(response.body)['data']['vendor']['name'].toString(),
//           json.decode(response.body)['data']['vendor']['id']);
//     } else if (response.statusCode == 404) {
//       cleanCartItems();
//     } else {
//       isFailed = true;
//       notifyListeners();
//     }
//   }
//   setCartItems(
//       List<CartItemModel> cartItemsRe, double total, String vname, int vId) {
//     if (kDebugMode) {
//       print("vID: $vId");
//     }
//     cartItems = cartItemsRe;
//     cartTotal = total;
//     vendorName = vname;
//     vendorId = vId;
//     isLoading = false;
//     isFailed = false;
//     notifyListeners();
//     }
//   Future<List> addToCart(itemId, Map bodyExtras) async {
//     isAdding = true;
//     notifyListeners();
//     final response = await api.post('/client/cart/add/$itemId', bodyExtras);
//     if (response.statusCode == 200) {
//       isAdding = false;
//       notifyListeners();
//       getCartItems();
//       return [true, json.decode(response.body)['message']];
//     } else {
//       isAdding = false;
//       notifyListeners();
//       return [false, json.decode(response.body)['message']];
//     }
//   }
//   increaseItem(String cartItemId) async {
//     isUpdating = true;
//     notifyListeners();
//     final response =
//         await api.put('/client/cart/$cartItemId/increase?qyt=1', {});
//     if (response.statusCode == 200) {
//       getCartItems();
//     } else {}
//     isUpdating = false;
//     notifyListeners();
//   }
//   decreaseItem(String cartItemId) async {
//     isUpdating = true;
//     notifyListeners();
//     final response =
//         await api.put('/client/cart/$cartItemId/decrease?qyt=1', {});
//     if (response.statusCode == 200) {
//       getCartItems();
//     } else {}
//     isUpdating = false;
//     notifyListeners();
//   }
//   removeItem(String cartItemId) async {
//     isUpdating = true;
//     notifyListeners();
//     final response = await api.post('/client/cart/remove/$cartItemId', {});
//     if (response.statusCode == 200) {
//       getCartItems();
//     } else {}
//     isUpdating = false;
//     notifyListeners();
//   }
//   cancelCart() async {
//     final response = await api.get('/client/cart/cancel', {});
//     if (response.statusCode == 200) {
//       cleanCartItems();
//     } else if (response.statusCode == 404) {
//     } else {}
//   }
//   cleanCartItems() {
//     cartItems = [];
//     cartTotal = 0;
//     vendorName = '';
//     isLoading = false;
//     isFailed = false;
//     notifyListeners();
//   }
// }
