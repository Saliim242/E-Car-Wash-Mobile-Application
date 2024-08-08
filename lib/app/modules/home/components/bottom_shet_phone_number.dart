// import 'package:ewash/app/modules/home/controllers/home_controller.dart';
// import 'package:ewash/app/modules/home/model/services_providers_model.dart';
// import 'package:ewash/utils/constants/api_or_keys_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// import '../../../../utils/constants/app_colors.dart';
// import '../../../../utils/constants/reusable_constants.dart';

// class PhoneNumberBottomSheet extends StatefulWidget {
//   PhoneNumberBottomSheet({super.key, required this.model});
//   final ServiceProvidersModel model;
//   @override
//   _PhoneNumberBottomSheetState createState() => _PhoneNumberBottomSheetState();
// }

// class _PhoneNumberBottomSheetState extends State<PhoneNumberBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode = BReusableConstants.isDarkMode(context);
//     return GetBuilder<HomeController>(builder: (hom) {
//       return ModalProgressHUD(
//         inAsyncCall: hom.isServiceBookingLoading,
//         blur: 0.85,
//         progressIndicator: Center(
//           child: Container(
//             alignment: Alignment.center,
//             width: 120,
//             height: 120,
//             decoration: BoxDecoration(
//               color: isDarkMode
//                   ? BAppColor.kCardDarkbgColor
//                   : BAppColor.kPrimaryColor,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: LoadingAnimationWidget.dotsTriangle(
//               size: 50,
//               color: BAppColor.kbgColor,
//             ),
//           ),
//         ),
//         child: Padding(
//           padding:
//               EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             height: MediaQuery.of(context).size.height * 0.25,
//             decoration: BoxDecoration(
//               color: isDarkMode ? Color(0xff181D2D) : BAppColor.kbgColor,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 topRight: Radius.circular(12),
//               ),
//             ),
//             child: ListView(
//               children: [
//                 Column(
//                   children: [
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                     Text(
//                       'Enter Your Phone Number',
//                       style: style(
//                         fontSize: 17,
//                         color: isDarkMode
//                             ? BAppColor.kbgColor
//                             : BAppColor.kTextStyleColor,
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                     Form(
//                       key: hom.bookingformKey,
//                       child: InternationalPhoneNumberInput(
//                         onInputChanged: (PhoneNumber number) {
//                           setState(() {
//                             hom.numberValue = number.toString();
//                           });
//                         },
//                         onInputValidated: (bool isValid) {
//                           print(isValid);
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Number is required'.tr;
//                           }
//                           return null;
//                         },
//                         selectorConfig: SelectorConfig(
//                           selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//                           leadingPadding: 8.0,
//                           trailingSpace: false,
//                           setSelectorButtonAsPrefixIcon: true,
//                         ),
//                         ignoreBlank: true,
//                         autoValidateMode: AutovalidateMode.onUserInteraction,
//                         selectorTextStyle: TextStyle(color: Colors.black),
//                         initialValue: hom.number,
//                         textFieldController: hom.phnoneController,
//                         formatInput: false,
//                         maxLength: 10,
//                         inputDecoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           labelText: 'Phone Number',
//                           hintText: 'Enter your phone number',
//                         ),
//                         // keyboardType: TextInputType.numberWithOptions(
//                         //   signed: true,
//                         //   decimal: true,

//                         // ),
//                         onSaved: (PhoneNumber number) {
//                           print('On Saved: $number');
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: CustomBookingButtom(
//                             color: BAppColor.kCheckOutInActiveBgColor,
//                             btnText: "Cancel",
//                             textcolor: BAppColor.kCheckOutActiveTextColor,
//                             onTap: () {
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ),
//                         Gap(kPadding),
//                         Expanded(
//                           child: CustomBookingButtom(
//                             btnText: "Book Now",
//                             onTap: () => hom.makeBookingService(widget.model),
//                             color: BAppColor.kPrimaryColor,
//                             textcolor: BAppColor.kbgColor,
//                           ),
//                         ),

//                         // ElevatedButton(
//                         //   onPressed: () {
//                         //     if (_formKey.currentState!.validate()) {
//                         //       _formKey.currentState!.save();
//                         //       Navigator.of(context).pop();
//                         //       _processPayment(context, _controller.text);
//                         //     }
//                         //   },
//                         //   child: Text('Proceed to Payment'),
//                         // ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

// class CustomBookingButtom extends StatelessWidget {
//   const CustomBookingButtom({
//     super.key,
//     required this.btnText,
//     this.onTap,
//     required this.color,
//     required this.textcolor,
//   });

//   final String btnText;
//   final Color color;
//   final Color textcolor;
//   final void Function()? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         alignment: Alignment.center,
//         width: MediaQuery.of(context).size.width,
//         height: 60,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           btnText,
//           style: TextStyle(
//             color: textcolor,
//             fontSize: 17,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }
