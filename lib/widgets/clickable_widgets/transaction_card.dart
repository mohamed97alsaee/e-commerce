import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.network(
                        // cartItemModel.image.fullPath,
                        'https://www.freepnglogos.com/uploads/iphone-png/the-iphone-ten-png-3.png',
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded) {
                            return child;
                          }
                          return AnimatedOpacity(
                            opacity: frame == null ? 0 : 1,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeOut,
                            child: child,
                          );
                        },
                        width: size.width * 0.15,
                        height: size.width * 0.15,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Image.asset(
                              'assets/cashLogo.png',
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product name', //  cartItemModel.name,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: themeListener.isDark
                                  ? lightWihteColor
                                  : Colors.black87),
                        ),
                        Text(
                          AppLocalizations.of(context)!.category,
                          //   "${cartItemModel.total} ${AppLocalizations.of(context)!.lyd}",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: themeListener.isDark
                                  ? lightWihteColor
                                  : middleGreyColor),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "${120.0} ${AppLocalizations.of(context)!.lyd}",
                  //   "${cartItemModel.total} ${AppLocalizations.of(context)!.lyd}",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: themeListener.isDark
                          ? lightWihteColor
                          : darkGreyColor),
                ),
              ],
            ),
          )),
    );
  }
}
