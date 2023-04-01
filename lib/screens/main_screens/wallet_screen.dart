import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/clickable_widgets/clickacble_text_widget.dart';
import '../../widgets/clickable_widgets/transaction_card.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.9,
                height: size.height * 0.22,
                decoration: BoxDecoration(
                    // color: mainColor,
                    gradient: LinearGradient(colors: [
                      mainColor,
                      mainColor.withOpacity(0.5),
                    ], begin: Alignment.topLeft, end: Alignment.topRight),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/chip.png',
                            width: size.width * 0.2,
                          ),
                          Text(
                              "${AppLocalizations.of(context)!.hi}, Mohammed Alfaitory !",
                              style: TextStyle(
                                  color: themeListener.isDark
                                      ? lightWihteColor
                                      : middleGreyColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.totalbalance,
                            style: TextStyle(
                                color: themeListener.isDark
                                    ? lightWihteColor
                                    : darkGreyColor,
                                fontSize: 19,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "120.75${AppLocalizations.of(context)!.lyd}",
                            style: TextStyle(
                                color: themeListener.isDark
                                    ? lightWihteColor
                                    : darkGreyColor,
                                fontSize: 40,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.activity,
                  style: TextStyle(
                      color: themeListener.isDark
                          ? lightWihteColor
                          : darkGreyColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                ClickableText(
                    color: themeListener.isDark
                        ? lightWihteColor
                        : middleGreyColor,
                    text: AppLocalizations.of(context)!.seeall,
                    onPressed: () {})
              ],
            ),
          ),
          ListView.builder(
              itemCount:
                  // cartConsumer.isLoading?
                  15, // : cartConsumer.cartItems.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return const AnimatedSwitcher(
                    duration: animationDuration,
                    child:
                        // cartConsumer.isLoading
                        //     ? Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: ShimmerWidget(
                        //           height: size.height * 0.12,
                        //         ),
                        //       )
                        //     :
                        TransactionCard());
              }),
        ],
      ),
    ));
  }
}
