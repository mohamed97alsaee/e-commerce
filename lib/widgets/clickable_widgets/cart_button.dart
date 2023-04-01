import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import '../../screens/sub_screens/cart_screen.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
              icon: Image.asset(
                'assets/icons/cartIcon.png',
                width: 25,
                height: 25,
                color: themeListener.isDark ? lightWihteColor : darkGreyColor,
              )),
        ),
        // if (cartConsumer.cartItems.isNotEmpty)
        // Positioned(
        //   top: 0,
        //   right: 0,
        //   child: Padding(
        //     padding: const EdgeInsets.all(12.0),
        //     child: Container(
        //         width: 13,
        //         height: 13,
        //         decoration: BoxDecoration(
        //           color: warningColor,
        //           border: Border.all(color: lightWihteColor, width: 0.3),
        //           borderRadius: BorderRadius.circular(200),
        //         ),
        //         child: Center(
        //           child: Text(
        //             cartConsumer.cartItems.length.toString(),
        //             style: const TextStyle(fontSize: 8, color: lightWihteColor),
        //           ),
        //         )),
        //   ),
        // )
      ],
    );
  }
}
