import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/clickable_widgets/cart_button.dart';
import '../../widgets/clickable_widgets/custom_icon_button.dart';
import '../../widgets/clickable_widgets/main_button_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          actions: const [CartButton()],
          title: Text(
            AppLocalizations.of(context)!.productdetails,
            style: TextStyle(
              color: themeListener.isDark ? lightWihteColor : darkGreyColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.3,
                  width: size.width,
                  child: Image.network(
                    'https://www.freepnglogos.com/uploads/iphone-png/the-iphone-ten-png-3.png',
                    fit: BoxFit.contain,
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(),
                ),
                Row(
                  children: [
                    Text(
                      "PRODUCT NAME",
                      style: TextStyle(
                        color: themeListener.isDark
                            ? lightWihteColor
                            : darkGreyColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "100.0 ${AppLocalizations.of(context)!.lyd}",
                      style: TextStyle(
                        color: themeListener.isDark
                            ? lightWihteColor
                            : darkGreyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        CustomIconButton(
                          icon: Icons.add,
                          onPressed: () {
                            setState(() {
                              qty++;
                            });
                          },
                        ),
                        Text(
                          qty.toString(),
                          style: TextStyle(
                            color: themeListener.isDark
                                ? lightWihteColor
                                : darkGreyColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomIconButton(
                          onPressed: () {
                            if (qty > 1) {
                              setState(() {
                                qty--;
                              });
                            }
                          },
                          icon: Icons.remove,
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.productdescription,
                      style: TextStyle(
                        color: themeListener.isDark
                            ? lightWihteColor
                            : darkGreyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                      """Cupiditate fugit voluptates est repudiandae provident animi quia praesentium. Illo magnam qui reiciendis vero officia quam nam. Ad fugit molestiae minus atque molestias vero in in
                 Blanditiis blanditiis nobis fugiat saepe accusamus delectus occaecati aperiam. Perferendis rerum nam expedita velit quod nam magni beatae hic. Odit sint sequi maxime aliquam exercitationem et.
                Suscipit voluptas accusamus sit omnis dolores. Temporibus nobis sed neque voluptatem non veritatis. Nesciunt magnam neque excepturi velit eaque temporibus quia dicta.""",
                      style: TextStyle(
                        color: themeListener.isDark
                            ? lightWihteColor
                            : darkGreyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MainButton(
                        horizontalPadding: 0,
                        heightFromScreen: 0.05,
                        radius: 5,
                        widthFromScreen: 0.4,
                        text: AppLocalizations.of(context)!.addtocart,
                        onPressed: () {}),
                    MainButton(
                        horizontalPadding: 0,
                        heightFromScreen: 0.05,
                        radius: 5,
                        btnColor: lightGreyColor,
                        widthFromScreen: 0.4,
                        text:
                            "${AppLocalizations.of(context)!.buy} ${AppLocalizations.of(context)!.now}",
                        onPressed: () {}),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
