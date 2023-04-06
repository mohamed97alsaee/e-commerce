import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/providers/products_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/clickable_widgets/filter_button.dart';
import '../../widgets/clickable_widgets/product_card.dart';
import '../../widgets/input_widgets/text_field_widget.dart';
import '../../widgets/static_widgets/banner_slider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  TextEditingController searchController = TextEditingController();

  int filterIndex = 0;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List filterList = [];
  // List<ProductModel> productsList = [];

  String? selectedCatUid;
  getCategoriess() {
    firestore.collection('categories').get().then((data) {
      for (var element in data.docs) {
        filterList.add(element.data());
      }
      setState(() {});
    });
  }

//   getProductsByCatUID(String catUID) {
//     firestore
//         .collection('products')
//         .where('category_uid', isEqualTo: selectedCatUid)
//         .get()
//         .then((data) {
//       productsList.clear();
// // print to json
//       // print("${data.docs.first['name_ar']} \n ${data.docs.first['name_en']}");
//       for (var element in data.docs) {
//         productsList.add(ProductModel.fromJson(element.data()));
//       }
//       setState(() {});
//     });
//   }

  @override
  void initState() {
    Provider.of<ProductsProvider>(context, listen: false).initProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    final productsFunctions =
        Provider.of<ProductsProvider>(context, listen: false);

    return SingleChildScrollView(
      child: Consumer<ProductsProvider>(
          builder: (context, productsProvider, child) {
        return AnimatedSwitcher(
          duration: animationDuration,
          child: Column(children: [
            TextFieldWidget(
                horizontalPadding: 14,
                perfix: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  child: Image.asset(
                    "assets/icons/searchIcon.png",
                    width: 15,
                    height: 15,
                  ),
                ),
                controller: searchController,
                hintText:
                    "${AppLocalizations.of(context)!.search} ${AppLocalizations.of(context)!.here}...",
                validator: (value) {
                  return null;
                },
                onchanged: () {
                  setState(() {});
                }),
            AnimatedSwitcher(
                duration: animationDuration,
                child: searchController.text.isEmpty
                    ? const BannerSlider()
                    : const SizedBox()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  AnimatedSwitcher(
                      duration: animationDuration,
                      child: searchController.text.isEmpty
                          ? Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.categories,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: themeListener.isDark
                                          ? lightWihteColor
                                          : darkGreyColor),
                                )
                              ],
                            )
                          : const SizedBox()),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return
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
                              FilterButton(
                            isSelected: index == filterIndex,
                            onPressed: () async {
                              filterIndex = index;
                              // selectedCatUid = productsProvider.categories[index].nameEn;
                              await firestore
                                  .collection('categories')
                                  .where('name_en',
                                      isEqualTo: productsProvider
                                          .categories[index].nameEn)
                                  .get()
                                  .then((value) {
                                selectedCatUid = value.docs[0].id;
                              });
                              // filterList[index]["uid"];
                              if (kDebugMode) {
                                print(selectedCatUid);
                              }
                              setState(() {});
                              productsFunctions
                                  .getProductsByCatUID(selectedCatUid!);
                            },
                            title:
                                AppLocalizations.of(context)!.localeName == "ar"
                                    ? productsProvider.categories[index].nameAr
                                    : productsProvider.categories[index].nameEn,
                          );
                        },
                        itemCount: productsProvider.categories
                            .length //vendorProviderConsumer.allTypes.length,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       AppLocalizations.of(context)!.recentproducts,
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           color: themeListener.isDark
                  //               ? lightWihteColor
                  //               : darkGreyColor),
                  //     ),
                  //     MainButton(
                  //         horizontalPadding: 0,
                  //         heightFromScreen: 0.03,
                  //         widthFromScreen: 0.25,
                  //         withBorder: true,
                  //         btnColor: lightWihteColor,
                  //         text: AppLocalizations.of(context)!.filter,
                  //         onPressed: () {})
                  //   ],
                  // ),
                  productsProvider.products.isEmpty
                      ? const Center(
                          child: Text('NO DATA'),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return
                                //  AnimatedSwitcher(
                                //     duration: animationDuration,
                                //     child:
                                // vendorProviderConsumer.isLoading
                                //     ? const Padding(
                                //         padding: EdgeInsets.all(8.0),
                                //         child: ShimmerWidget(
                                //           radius: 15,
                                //         ),
                                //       )
                                //     :
                                ProductCard(
                              productModel: productsProvider.products[index],
                            );
                            // );
                          },
                          itemCount: productsProvider.products.length
                          //  vendorProviderConsumer.isLoading
                          //     ? 10
                          //     : vendorProviderConsumer.vendors.length,
                          ),
                ],
              ),
            ),
          ]),
        );
      }),
    );
  }
}
