import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'custom_icon_button.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    //  required this.cartItemModel
  });
  // final CartItemModel cartItemModel;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<DarkThemeProvider>(
        builder: (context, themeListener, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: themeListener.isDark
                  ? lightWihteColor.withOpacity(0.2)
                  : Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                if (!themeListener.isDark)
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 0))
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                              value: loadingProgress.expectedTotalBytes != null
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
                    const SizedBox(
                      height: 10,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Product name', //  cartItemModel.name,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.transparent),
                    ),
                    Text(
                      AppLocalizations.of(context)!.category,
                      //   "${cartItemModel.total} ${AppLocalizations.of(context)!.lyd}",
                      style: const TextStyle(
                          fontSize: 14, color: Colors.transparent),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomIconButton(
                            icon: Icons.add,
                            onPressed: () {
                              if (kDebugMode) {
                                print('PLUS');
                              }
                              //   Provider.of<CartProvider>(context, listen: false)
                              //       .increaseItem(cartItemModel.id.toString());
                            }),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            3.toString(), //     cartItemModel.qty.toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: themeListener.isDark
                                    ? lightWihteColor
                                    : darkGreyColor.withOpacity(0.6)),
                          ),
                        ),
                        CustomIconButton(
                            icon: Icons.remove,
                            onPressed: () {
                              if (kDebugMode) {
                                print('MINUS');
                              }
                            }),
                        CustomIconButton(
                          onPressed: () {
                            if (kDebugMode) {
                              print('DELETE');
                            }
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Text(
                                        AppLocalizations.of(context)!
                                            .removeitem,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              // Provider.of<CartProvider>(context,
                                              //         listen: false)
                                              //     .removeItem(cartItemModel.id
                                              //         .toString());
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .remove)),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .no)),
                                      ],
                                    ));
                          },
                          icon: Icons.delete_outline_rounded,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
