import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/clickable_widgets/cart_button.dart';
import '../../widgets/clickable_widgets/previous_product_card.dart';

class PreviousOrderDaetailsScreen extends StatelessWidget {
  const PreviousOrderDaetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: const [CartButton()],
        title: Text(AppLocalizations.of(context)!.orderdetails),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount:
                    // cartConsumer.isLoading?
                    4, // : cartConsumer.cartItems.length,
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
                          PreviousProductCard());
                }),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: size.height * 0.15,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.total,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: themeListener.isDark
                          ? lightWihteColor
                          : darkGreyColor.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    "240.0 ${AppLocalizations.of(context)!.lyd}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: themeListener.isDark
                          ? lightWihteColor
                          : darkGreyColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
