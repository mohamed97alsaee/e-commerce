import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/clickable_widgets/clickacble_text_widget.dart';
import '../../widgets/clickable_widgets/location_card.dart';
import '../../widgets/dialogs/reciept_request_conent_dialog.dart';
import '../../widgets/input_widgets/image_viewer_with_uploader.dart';
import '../../widgets/input_widgets/text_field_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  bool busyLocation = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return RecieptRequestDialogContent(
                    success: true,
                    title: "Reciept Request",
                    subTitle:
                        "you Accpeted to pay 200 LYD to the account #34342",
                    buttonText: "ACCEPT",
                    onPressed: () {});
              });
        }),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const ImageViewerWithUploader(uploadable: true),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Level 1',
                style: TextStyle(
                    color: mainColor,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: size.width * 0.6,
                child: LinearProgressIndicator(
                  value: 0.5,
                  backgroundColor: mainColor.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(mainColor),
                ),
              ),
              TextFieldWidget(
                  label: AppLocalizations.of(context)!.username,
                  controller: nameController,
                  hintText: AppLocalizations.of(context)!.username,
                  validator: (value) {
                    return null;
                  },
                  onchanged: () {}),
              TextFieldWidget(
                  label: AppLocalizations.of(context)!.email,
                  controller: emailController,
                  hintText: AppLocalizations.of(context)!.email,
                  validator: (value) {
                    return null;
                  },
                  onchanged: () {}),
              TextFieldWidget(
                  label: AppLocalizations.of(context)!.phone,
                  controller: phoneController,
                  hintText: AppLocalizations.of(context)!.phone,
                  validator: (value) {
                    return null;
                  },
                  onchanged: () {}),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.addresses,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: themeListener.isDark
                              ? lightWihteColor
                              : Colors.black87),
                    ),
                    ClickableText(
                        text: AppLocalizations.of(context)!.addnewaddress,
                        color: middleGreyColor,
                        withUnderline: true,
                        onPressed: () async {
                          // setState(() {
                          //   busyLocation = true;
                          // });

                          // bool serviceEnabled;
                          // LocationPermission permission;

                          // // Test if location services are enabled.
                          // serviceEnabled =
                          //     await Geolocator.isLocationServiceEnabled();
                          // if (!serviceEnabled) {
                          //   // Location services are not enabled don't continue
                          //   // accessing the position and request users of the
                          //   // App to enable the location services.
                          //   return Future.error(
                          //       'Location services are disabled.');
                          // }

                          // permission = await Geolocator.checkPermission();
                          // if (permission == LocationPermission.denied) {
                          //   permission = await Geolocator.requestPermission();
                          //   if (permission == LocationPermission.denied) {
                          //     // Permissions are denied, next time you could try
                          //     // requesting permissions again (this is also where
                          //     // Android's shouldShowRequestPermissionRationale
                          //     // returned true. According to Android guidelines
                          //     // your App should show an explanatory UI now.
                          //     return Future.error(
                          //         'Location permissions are denied');
                          //   }
                          // }

                          // if (permission == LocationPermission.deniedForever) {
                          //   // Permissions are denied forever, handle appropriately.
                          //   return Future.error(
                          //       'Location permissions are permanently denied, we cannot request permissions.');
                          // }

                          // // When we reach here, permissions are granted and we can
                          // // continue accessing the position of the device.
                          // return await Geolocator.getCurrentPosition()
                          //     .then((locationValue) {
                          //   if (kDebugMode) {
                          //     print(
                          //         'Latitude: ${locationValue.latitude}, Longitude: ${locationValue.longitude}');
                          //   }
                          //   locationValue.toString() != 'null'
                          //       ? showDialog(
                          //           context: context,
                          //           builder: (BuildContext context) {
                          //             return Dialog(
                          //               shape: RoundedRectangleBorder(
                          //                 borderRadius:
                          //                     BorderRadius.circular(20.0),
                          //               ), //this right here
                          //               child: NewAddressDialogContent(
                          //                 latitude: locationValue.latitude,
                          //                 longtude: locationValue.longitude,
                          //               ),
                          //             );
                          //           })
                          //       : showCustomFlushbar(
                          //           AppLocalizations.of(context)!.swr,
                          //           warningColor,
                          //           Icons.location_off_rounded,
                          //           context);
                          //   setState(() {
                          //     busyLocation = false;
                          //   });
                          // });
                          // }
                        })
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: size.height * 0.15,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const LocationCard();
                      },
                      itemCount: 10 //vendorProviderConsumer.allTypes.length,
                      ),
                ),
              ),
            ],
          ),
        ));
  }
}
