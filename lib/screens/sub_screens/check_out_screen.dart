import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/clickable_widgets/clickacble_text_widget.dart';
import '../../widgets/clickable_widgets/main_button_widget.dart';
import '../../widgets/clickable_widgets/payment_button.dart';
import '../handling_screens/suceess_order_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  int currentPaymentIndex = 0;
  final TextEditingController messageToSellerController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themListener = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.checkout),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.deliveryaddress,
                    style: TextStyle(
                      color:
                          themListener.isDark ? lightWihteColor : darkGreyColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/mapShape.png',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: size.width * 0.5,
                        child: Text(
                          AppLocalizations.of(context)!.deliveryaddress,
                          style: TextStyle(
                              color: themListener.isDark
                                  ? lightWihteColor
                                  : darkGreyColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  ClickableText(
                      color: Colors.grey,
                      text: AppLocalizations.of(context)!.change,
                      onPressed: () {})
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.paymentmethod,
                    style: TextStyle(
                      color:
                          themListener.isDark ? lightWihteColor : darkGreyColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: size.height * 0.08,
                child: ListView(
                  //. (builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    PaymentButton(
                        isSelected: currentPaymentIndex == 1,
                        image: "assets/icons/walletIcon.png",
                        onTap: () {
                          if (kDebugMode) {
                            print("WALLET");
                          }
                          setState(() {
                            currentPaymentIndex = 1;
                          });
                        }),
                    PaymentButton(
                        isSelected: currentPaymentIndex == 2,
                        image: "assets/edfali.png",
                        onTap: () {
                          if (kDebugMode) {
                            print("EDFALI");
                          }
                          setState(() {
                            currentPaymentIndex = 2;
                          });
                        }),
                    PaymentButton(
                        isSelected: currentPaymentIndex == 3,
                        image: "assets/raseed.png",
                        onTap: () {
                          if (kDebugMode) {
                            print("RASEED");
                          }
                          setState(() {
                            currentPaymentIndex = 3;
                          });
                        }),
                    // PaymentButton(
                    //     image: "assets/sadad.png",
                    //     onTap: () {
                    //       if (kDebugMode) {
                    //         print("SADAD");
                    //       }
                    //     }),
                    PaymentButton(
                        isSelected: currentPaymentIndex == 4,
                        image: "assets/mobiCash.png",
                        onTap: () {
                          if (kDebugMode) {
                            print("MOBI");
                          }
                          setState(() {
                            currentPaymentIndex = 4;
                          });
                        }),
                  ],
                  // itemBuilder: (context, index) {
                  //   return
                  //  vendorProviderConsumer.isLoading
                  //     ?
                  //     Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8),
                  //   child: ShimmerWidget(
                  //     width: size.width / 3,
                  //     height: size.height * 0.04,
                  //     radius: 50,
                  //   ),
                  // );
                  //     :
                  //       FilterButton(
                  //     isSelected: index == filterIndex,
                  //     onPressed: () {
                  //       setState(() {
                  //         filterIndex = index;
                  //       });
                  //     },
                  //     title: filterList[index]["title"],
                  //   );
                  // },
                  // itemCount: filterList
                  //     .length //vendorProviderConsumer.allTypes.length,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MainButton(
                  horizontalPadding: 0,
                  btnColor: lightGreyColor.withOpacity(0.3),
                  txtColor:
                      themListener.isDark ? lightWihteColor : middleGreyColor,
                  text: AppLocalizations.of(context)!.addcoupon,
                  onPressed: () {
                    if (kDebugMode) {
                      print("ADD COUPON");
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: TextField(
                  maxLines: 5,
                  controller: messageToSellerController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.messagetoseller,
                    hintStyle: TextStyle(
                      color: themListener.isDark
                          ? lightWihteColor.withOpacity(0.5)
                          : middleGreyColor.withOpacity(0.5),
                    ),
                    fillColor: lightGreyColor.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.totalitems} (3)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: themListener.isDark
                          ? lightWihteColor
                          : darkGreyColor.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    "215.0 ${AppLocalizations.of(context)!.lyd}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          themListener.isDark ? lightWihteColor : darkGreyColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.deliveryfee,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: themListener.isDark
                          ? lightWihteColor
                          : darkGreyColor.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    "25.0 ${AppLocalizations.of(context)!.lyd}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          themListener.isDark ? lightWihteColor : darkGreyColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.totalpayment,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: themListener.isDark
                          ? lightWihteColor
                          : darkGreyColor.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    "240.0 ${AppLocalizations.of(context)!.lyd}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          themListener.isDark ? lightWihteColor : darkGreyColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: size.height * 0.2,
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
                      color: themListener.isDark
                          ? lightWihteColor
                          : darkGreyColor.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    "240.0 ${AppLocalizations.of(context)!.lyd}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          themListener.isDark ? lightWihteColor : darkGreyColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              MainButton(
                  horizontalPadding: 0,
                  // heightFromScreen: 0.05,
                  radius: 5,
                  btnColor: lightGreyColor,
                  // widthFromScreen: 0.4,
                  text: AppLocalizations.of(context)!.continuetopayment,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SuccessOrderScreen()));
                  }),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
