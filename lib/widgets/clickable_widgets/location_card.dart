import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationCard extends StatefulWidget {
  const LocationCard({super.key});

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        width: size.width / 4,
        decoration: BoxDecoration(
            color: themeListener.isDark
                ? lightWihteColor.withOpacity(0.1)
                : mainColor,
            boxShadow: [
              if (!themeListener.isDark)
                const BoxShadow(
                  color: lightGreyColor,
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(1, 1),
                ),
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              AppLocalizations.of(context)!.addressname,
              style: const TextStyle(
                  color: lightWihteColor, fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.addressdetails,
                  style: const TextStyle(
                      fontSize: 9,
                      color: lightWihteColor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  AppLocalizations.of(context)!.addressdetails,
                  style: const TextStyle(
                      fontSize: 9,
                      color: lightWihteColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
