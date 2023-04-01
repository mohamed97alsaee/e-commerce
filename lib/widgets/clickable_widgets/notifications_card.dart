import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: () {
          if (kDebugMode) {
            print("CLICKED ON NOTIFICATION CARD");
          }
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => const PreviousOrderDaetailsScreen()));
        },
        child: Container(
            decoration: BoxDecoration(
              color: themeListener.isDark
                  ? lightWihteColor.withOpacity(0.1)
                  : lightWihteColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                if (!themeListener.isDark)
                  const BoxShadow(
                    color: lightGreyColor,
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notification Title', //  cartItemModel.name,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: themeListener.isDark
                                ? lightWihteColor
                                : Colors.black87),
                      ),
                      Text(
                        "14 Feb , 2023 12:00 PM",
                        //   "${cartItemModel.total} ${AppLocalizations.of(context)!.lyd}",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: themeListener.isDark
                                ? lightWihteColor
                                : middleGreyColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.8,
                        child: Text(
                          "Notfication Description for one line of content.",
                          //   "${cartItemModel.total} ${AppLocalizations.of(context)!.lyd}",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: themeListener.isDark
                                  ? lightWihteColor
                                  : middleGreyColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
