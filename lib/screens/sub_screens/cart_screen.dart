import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../models/address_model.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/clickable_widgets/cart_item_card.dart';
import '../../widgets/clickable_widgets/main_button_widget.dart';
import 'check_out_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<AddressModel> adressess = [
    AddressModel(id: 0, name: 'Home', long: "22.232", lat: "22.232"),
    AddressModel(id: 1, name: 'Work', long: "22.232", lat: "22.232"),
    AddressModel(id: 2, name: 'Shop', long: "22.232", lat: "22.232"),
  ];
  AddressModel? _selectedAddress;
  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.cart),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.devilveryto),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<AddressModel>(
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        hint: Text(
                          AppLocalizations.of(context)!.address,
                        ),
                        style: GoogleFonts.almarai(
                            color: Colors
                                .black38), // const TextStyle(color: Colors.black38),
                        value: _selectedAddress,
                        items:
                            // addressesConsumer.addresses.map((AddressModel value)
                            adressess.toList().map((AddressModel value) {
                          return DropdownMenuItem<AddressModel>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: (AddressModel? value) {
                          setState(() {
                            _selectedAddress = value;
                          });
                          if (kDebugMode) {
                            print("Address: ${value!.id}");
                          }
                        }),
                  ),
                ],
              ),
            ),
            const Divider(),
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
                        CartItemCard(
                            // cartItemModel:
                            //     cartConsumer.cartItems[index]
                            ),
                  );
                }),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.total,
                    style: TextStyle(
                        color: themeListener.isDark
                            ? lightWihteColor
                            : Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  Text("${765.50} ${AppLocalizations.of(context)!.lyd}"),
                ],
              ),
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
                          builder: (context) => const CheckOutScreen()));
                }),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
