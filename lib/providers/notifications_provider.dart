// import 'dart:convert';

// import 'package:flutter/foundation.dart';

// import '../services/api.dart';

// class NotificationsProvider with ChangeNotifier {
//   final Api _api = Api();
//   bool loading = true;
//   bool failed = false;
//   bool haveUnread = false;
//   int currentPage = 1;
//   late int lastPage;

//   List<NotificationModel> notifications = [];

//   initialProvider() {
//     loading = true;
//     haveUnread = false;
//     failed = false;
//     notifications = [];
//     currentPage = 1;
//     lastPage = 100;
//     loading = false;
//     getNotifications(1);
//     notifyListeners();
//   }

//   Future getNotifications(pageNum) async {
//     if (pageNum == 1) loading = true;
//     notifyListeners();
//     failed = false;

//     var response = await _api.getNotifications(pageNum);
//     if (kDebugMode) {
//       print("RES FROM PROVIDER : $response");
//     }

//     List<NotificationModel> notificationData = [];

//     if (response.statusCode == 200) {
//       failed = false;

//       if (response.body.isNotEmpty) {
//         var data = jsonDecode(response.body)['data'];

//         notificationData =
//             (data as List).map((i) => NotificationModel.fromJson(i)).toList();
//       }
//     } else {
//       failed = true;
//     }
//     setNotificatons(notificationData);

//     loading = false;
//     notifyListeners();
//   }

//   setNotificatons(value) {
//     notifications.addAll(value);
//     loading = false;

//     notifyListeners();
//   }

//   makeHaveUnread() {
//     if (kDebugMode) {
//       print('makeHaveUnread');
//     }
//     haveUnread = true;
//     notifyListeners();
//   }

//   makeHaveNoUnread() {
//     if (kDebugMode) {
//       print('makeHaveNoUnread');
//     }
//     haveUnread = false;
//     notifyListeners();
//   }
// }
