import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:shared_preferences/shared_preferences.dart';

storeData(
  String key,
  value,
) async {
  SharedPreferences storage = await SharedPreferences.getInstance();
  await storage.setString(key, value);
}

getFileSize<List>(String path) {
  final file = File(path);
  int sizeInBytes = file.lengthSync();
  double sizeInMb = sizeInBytes / (1024 * 1024);
  if (kDebugMode) {
    print(sizeInMb);
  }
  if (sizeInMb < 8) {
    return [true, sizeInMb];
  } else {
    return [false, sizeInMb];
  }
}

setLang(String landCode) async {
  SharedPreferences langStorage = await SharedPreferences.getInstance();
  await langStorage.setString('langCode', landCode);
}

String getInitials({
  required String string,
}) {
  var buffer = StringBuffer();
  var split = string.split(' ');
  for (var i = 0; i < (string.split(' ').length > 1 ? 2 : 1); i++) {
    buffer.write(split[i][0]);
  }

  return buffer.toString();
}

// getFromGallery() async {
//   XFile? pickedFile = await ImagePicker().pickImage(
//     source: ImageSource.gallery,
//     maxWidth: 1800,
//     maxHeight: 1800,
//   );
//   if (pickedFile != null) {
//     return File(pickedFile.path);
//   }
// }

// getFromCamera() async {
//   XFile? pickedFile = await ImagePicker().pickImage(
//     source: ImageSource.camera,
//     maxWidth: 1800,
//     maxHeight: 1800,
//   );
//   if (pickedFile != null) {
//     return File(pickedFile.path);
//   }
// }

num? convStrToNum(String str) {
  var oneten = <String, num>{
    'one': 1,
    'two': 2,
    'three': 3,
    'four': 4,
    'five': 5,
    'six': 6,
    'seven': 7,
    'eight': 8,
    'nine': 9,
    'ten': 10,
  };
  if (oneten.keys.contains(str)) {
    return oneten[str];
  } else {
    return 0;
  }
}

// String returnMonth(DateTime date, BuildContext context) {
//   return DateFormat.MMMM(AppLocalizations.of(context)!.localeName).format(date);
// }

// Future<File> compressFile(File file) async {
//   File compressedFile = await FlutterNativeImage.compressImage(
//     file.path,
//     quality: 80,
//   );
//   if (kDebugMode) {
//     print("SIZE IS : ${compressedFile.lengthSync()} bytes");
//   }
//   return compressedFile;
// }

setStringToPrefs(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String?> getStringFromPrefs(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? value = prefs.getString(key);
  return value;
}

getFromGallery() async {
  XFile? pickedFile = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
}

getFromCamera() async {
  XFile? pickedFile = await ImagePicker().pickImage(
    source: ImageSource.camera,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
}

Future<File> compressFile(File file) async {
  File compressedFile = await FlutterNativeImage.compressImage(
    file.path,
    quality: 80,
  );
  if (kDebugMode) {
    print("SIZE IS : ${compressedFile.lengthSync()} bytes");
  }
  return compressedFile;
}
