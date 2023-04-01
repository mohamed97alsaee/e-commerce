// import 'dart:async';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';

// import '../../helpers/consts.dart';
// import '../../providers/addresses_provider.dart';
// import '../clickable_widgets/custom_icon_button.dart';
// import '../clickable_widgets/main_button_widget.dart';
// import '../input_widgets/text_field_widget.dart';
// import 'custom_flushbar_widget.dart';
// import 'map_picker.dart';

// class NewAddressDialogContent extends StatefulWidget {
//   const NewAddressDialogContent(
//       {super.key, required this.latitude, required this.longtude});
//   final double latitude;
//   final double longtude;

//   @override
//   State<NewAddressDialogContent> createState() =>
//       _NewAddressDialogContentState();
// }

// class _NewAddressDialogContentState extends State<NewAddressDialogContent> {
//   final GlobalKey<FormState> addressForm = GlobalKey<FormState>();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _discreptionController = TextEditingController();
//   bool enableAddButton = false;
//   LatLng? location;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SizedBox(
//       height: size.height * 0.5,
//       child: Form(
//         key: addressForm,
//         onChanged: () {
//           setState(() {
//             enableAddButton = addressForm.currentState!.validate();
//           });
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//                 child: Text(
//                   AppLocalizations.of(context)!.addnewaddress,
//                   style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
//                 child: Column(
//                   children: [
//                     Text(
//                       AppLocalizations.of(context)!.etdoycl,
//                       style: const TextStyle(
//                           fontSize: 9,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         CustomIconButton(
//                             onPressed: () async {
//                               await Navigator.push(
//                                   context,
//                                   CupertinoPageRoute(
//                                       builder: (context) => MapPicker(
//                                             initZoom: 14.4746,
//                                             initCoordinates: LatLng(
//                                                 widget.latitude,
//                                                 widget.longtude),
//                                           ))).then((value) {
//                                 if (value != null) {
//                                   setState(() {
//                                     location = value;
//                                   });
//                                 }
//                               });
//                             },
//                             icon: Icons.location_on),
//                         // Text(
//                         //     "LAT : ${location?.latitude.toString().substring(0, 8)}"),
//                         // Text(
//                         //     "LONG : ${location?.longitude.toString().substring(0, 8)}"),
//                         const SizedBox(
//                           width: 1,
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               TextFieldWidget(
//                   controller: _titleController,
//                   hintText: AppLocalizations.of(context)!.addressname,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "${AppLocalizations.of(context)!.please} ${AppLocalizations.of(context)!.enteryouraddresstitle}";
//                     }
//                     return null;
//                   },
//                   onchanged: () {}),
//               TextFieldWidget(
//                   controller: _discreptionController,
//                   hintText:
//                       "${AppLocalizations.of(context)!.description} ${AppLocalizations.of(context)!.address}",
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "${AppLocalizations.of(context)!.please} ${AppLocalizations.of(context)!.enteryourdescription}";
//                     }
//                     return null;
//                   },
//                   onchanged: () {}),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Consumer<AddressesProvider>(
//                       builder: (context, addressesProvider, child) {
//                     return MainButton(
//                         inProgress: addressesProvider.isLoading,
//                         isActive: enableAddButton && location != null,
//                         widthFromScreen: 0.25,
//                         text: AppLocalizations.of(context)!.add,
//                         onPressed: () async {
//                           Provider.of<AddressesProvider>(context, listen: false)
//                               .addNewAddress({
//                             "name": _titleController.text,
//                             "description": _discreptionController.text,
//                             "lat": location!.latitude,
//                             "long": location!.longitude
//                           }).then((value) {
//                             if (value.first) {
//                               showCustomFlushbar(value.last, successColor,
//                                   Icons.close, context);
//                               Timer(const Duration(seconds: 3), () {
//                                 Navigator.of(context).pop();
//                               });
//                               // .then((value) {
//                               // Navigator.of(context).pop();
//                               // });
//                             } else {
//                               showCustomFlushbar(value.last, warningColor,
//                                   Icons.close, context);
//                             }
//                           });
//                         });
//                   }),
//                   MainButton(
//                       withBorder: true,
//                       btnColor: lightWihteColor,
//                       txtColor: mainColor,
//                       widthFromScreen: 0.25,
//                       text: AppLocalizations.of(context)!.cancel,
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       }),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
