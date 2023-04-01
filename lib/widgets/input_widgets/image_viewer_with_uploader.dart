import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/consts.dart';
import '../../../providers/dark_theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../helpers/functions_helper.dart';

class ImageViewerWithUploader extends StatefulWidget {
  const ImageViewerWithUploader({Key? key, required this.uploadable})
      : super(key: key);
  final bool uploadable;
  @override
  State<ImageViewerWithUploader> createState() =>
      _ImageViewerWithUploaderState();
}

class _ImageViewerWithUploaderState extends State<ImageViewerWithUploader> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    // final registerProviderFucntions =
    //     Provider.of<RegisterProvider>(context, listen: false);
    // RegisterProvider registerProviderListener =
    //     Provider.of<RegisterProvider>(context, listen: true);
    // final userProviderFucntions =
    //     Provider.of<UserProvider>(context, listen: false);
    // return Consumer<UserProvider>(builder: (context, userProvider, _) {
    return GestureDetector(
      onTap: () async {
        if (widget.uploadable) {
          showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
                backgroundColor:
                    themeListener.isDark ? darkGreyColor : lightWihteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                content: Text(
                  AppLocalizations.of(context)!.imagesource,
                  style: TextStyle(
                      color: themeListener.isDark
                          ? lightWihteColor
                          : darkGreyColor),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.camera_alt,
                        color:
                            themeListener.isDark ? lightWihteColor : mainColor),
                    onPressed: () async {
                      File file = await getFromCamera();

                      if (file.path.toString() != 'null') {
                        // File cf = await compressFile(file);

                        // ignore: use_build_context_synchronously
                        // await registerProviderFucntions
                        //     .upload(cf, null, context)
                        //     .then((value) => userProviderFucntions
                        //             .updateProfile({
                        //           "profile_photo":
                        //               registerProviderListener.imgLink
                        //         }).then((value) => Navigator.pop(context)));
                      } else {}
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.image,
                      color: themeListener.isDark ? lightWihteColor : mainColor,
                    ),
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                          allowCompression: true,
                          onFileLoading: (p0) {
                            if (kDebugMode) {
                              print("DATA : ${p0.name}");
                            }
                          },
                          type: FileType.custom,
                          allowedExtensions: ['jpeg', 'jpg', 'png'],
                          withReadStream: true);

                      if (result != null) {
                        // File file = File(result.files.single.path!);
                        // File cf = await compressFile(file);

                        // ignore: use_build_context_synchronously
                        // await registerProviderFucntions
                        //     .upload(cf, null, context)
                        //     .then((value) => userProviderFucntions
                        //             .updateProfile({
                        //           "profile_photo":
                        //               registerProviderListener.imgLink
                        // }).then((value) => Navigator.pop(context)));
                      } else {}
                    },
                  ),
                ]),
          );
        }
      },
      child: CircleAvatar(
        radius: size.width / 7,
        backgroundColor: lightGreyColor.withOpacity(0.2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
              "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80", //  userProvider.currentUser.user.profilePhoto.toString(),
              fit: BoxFit.cover,
              scale: 0.5,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return SizedBox(
                      width: (size.width / 7) * 2,
                      height: (size.width / 7) * 2,
                      child: child);
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: themeListener.isDark ? lightWihteColor : mainColor,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, url, error) => Text(
                  getInitials(
                          string:
                              "Mohamed Alsaee" // userProvider.currentUser.user.name,
                          )
                      .toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    color:
                        themeListener.isDark ? lightWihteColor : darkGreyColor,
                  )),
              width: size.width / 5),
        ),
      ),
    );
    // });
  }
}
