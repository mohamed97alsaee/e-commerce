import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import '../../screens/sub_screens/product_screen.dart';
import '../dialogs/custom_flushbar_widget.dart';
import 'main_button_widget.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => const ProductScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: themeListener.isDark ? Colors.white10 : lightWihteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                if (!themeListener.isDark)
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    'https://www.freepnglogos.com/uploads/iphone-png/the-iphone-ten-png-3.png',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                          child: Icon(
                        Icons.image,
                        color: themeListener.isDark
                            ? lightWihteColor
                            : darkGreyColor,
                      ));
                    },
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "product name",
                      style: TextStyle(
                          color: themeListener.isDark
                              ? lightWihteColor
                              : darkGreyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "98 ${AppLocalizations.of(context)!.lyd}",
                      style: TextStyle(
                          color: themeListener.isDark
                              ? lightWihteColor
                              : darkGreyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                MainButton(
                  horizontalPadding: 0,
                  radius: 5,
                  heightFromScreen: .04,
                  text: AppLocalizations.of(context)!.addtocart,
                  onPressed: () {
                    showCustomFlushbar(
                        AppLocalizations.of(context)!.addedsuccessfully,
                        successColor,
                        Icons.add_shopping_cart_outlined,
                        context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
