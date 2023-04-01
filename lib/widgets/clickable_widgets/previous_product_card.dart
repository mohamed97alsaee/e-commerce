import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PreviousProductCard extends StatelessWidget {
  const PreviousProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            height: size.height * 0.3,
            decoration: BoxDecoration(
                color: themeListener.isDark
                    ? lightWihteColor.withOpacity(0.1)
                    : lightWihteColor,
                boxShadow: [
                  if (!themeListener.isDark)
                    const BoxShadow(
                      color: lightGreyColor,
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                ],
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
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
                      width: size.width,
                      height: size.width * 0.3,
                      fit: BoxFit.contain,
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
                  Text(
                    "Product Name",
                    style: TextStyle(
                        color: themeListener.isDark
                            ? lightWihteColor
                            : darkGreyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  Text(
                    "9823749874839398",
                    style: TextStyle(
                        color: themeListener.isDark
                            ? lightWihteColor
                            : darkGreyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  Text(
                    "200 ${AppLocalizations.of(context)!.lyd}",
                    style: const TextStyle(
                        color: mainColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                          color: themeListener.isDark
                              ? Colors.grey
                              : lightWihteColor,
                          boxShadow: [
                            if (!themeListener.isDark)
                              const BoxShadow(
                                color: lightGreyColor,
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                          ],
                          borderRadius: BorderRadius.circular(200)),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Icon(
                          Icons.copy_outlined,
                          color: themeListener.isDark
                              ? lightWihteColor
                              : darkGreyColor,
                        ),
                      )),
                  onTap: () {})
            ],
          ),
        ),
      ],
    );
  }
}
