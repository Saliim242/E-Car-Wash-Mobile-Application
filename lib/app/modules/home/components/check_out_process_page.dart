import 'dart:developer';
import 'package:ewash/app/modules/home/controllers/home_controller.dart';
import 'package:ewash/app/modules/home/model/services_providers_model.dart';
import 'package:ewash/app/modules/user/components/custom_textfield.dart';
import 'package:ewash/utils/constants/reusable_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../components/new_popular_service_card.dart';

class CheckOutProcessPage extends StatefulWidget {
  const CheckOutProcessPage({super.key, required this.serProvider});
  final ServiceProvidersModel serProvider;

  @override
  State<CheckOutProcessPage> createState() => _CheckOutProcessPageState();
}

class _CheckOutProcessPageState extends State<CheckOutProcessPage> {
  DateTime? selectedDateTime;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          selectedDateTime?.hour ?? 0,
          selectedDateTime?.minute ?? 0,
        );
        _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? DateTime.now()),
    );

    if (pickedTime != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime?.year ?? DateTime.now().year,
          selectedDateTime?.month ?? DateTime.now().month,
          selectedDateTime?.day ?? DateTime.now().day,
          pickedTime.hour,
          pickedTime.minute,
        );
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    return GetBuilder<HomeController>(
      builder: (home) {
        return ModalProgressHUD(
          inAsyncCall: home.isServiceBookingLoading,
          blur: 0.85,
          progressIndicator: Center(
            child: Container(
              alignment: Alignment.center,
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? BAppColor.kCardDarkbgColor
                    : BAppColor.kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: LoadingAnimationWidget.dotsTriangle(
                size: 50,
                color: BAppColor.kbgColor,
              ),
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              leading: backArrow(),
              elevation: 0,
              backgroundColor:
                  isDarkMode ? BAppColor.kCardDarkbgColor : Colors.white,
              title: Text(
                "Booking Check-Out Process",
                style: style(
                  fontSize: 16,
                  color: isDarkMode
                      ? BAppColor.kbgColor
                      : BAppColor.kTextStyleColor,
                ),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: home.bookingformKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Gap(kPadding + 10),
                      NewPopularServiceCard(
                        serProvider: widget.serProvider,
                      ),
                      Gap(kPadding + 10),
                      CustomTextFeilds(
                        errorText: "Bookin Date is required",
                        onTapTextFeild: () => _selectDate(context),
                        readOnly: true,
                        hintText: "Enter Date Booking",
                        showPassowrd: false,
                        controller: _dateController,
                        iconData: Icons.calendar_month,
                        onTap: () => _selectDate(context),
                      ),
                      Gap(kPadding + 10),
                      CustomTextFeilds(
                        errorText: "Bookin Time is required",
                        onTapTextFeild: () => _selectTime(context),
                        readOnly: true,
                        hintText: "Enter Time Booking",
                        showPassowrd: false,
                        controller: _timeController,
                        iconData: Icons.calendar_month,
                        onTap: () => _selectTime(context),
                      ),
                      // Gap(kPadding + 10),
                      // CustomTextFeilds(
                      //   errorText: "Phone Number is required",
                      //   //onTapTextFeild: () => _selectTime(context),
                      //   //readOnly: true,
                      //   hintText: "Enter Phone Number",
                      //   showPassowrd: false,
                      //   controller: _phoneController,
                      //   iconData: Icons.calendar_month,
                      // ),
                      Gap(kPadding + 10),
                      InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          setState(() {
                            home.numberValue = number.toString();
                          });
                        },
                        onInputValidated: (bool isValid) {
                          print(isValid);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Number is required'.tr;
                          }
                          return null;
                        },
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          leadingPadding: 8.0,
                          trailingSpace: false,
                          setSelectorButtonAsPrefixIcon: true,
                        ),
                        ignoreBlank: true,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        selectorTextStyle: TextStyle(color: Colors.black),
                        initialValue: home.number,
                        textFieldController: home.phnoneController,
                        formatInput: false,
                        maxLength: 10,
                        inputDecoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelText: 'Phone Number',
                          hintText: 'Enter your phone number',
                        ),
                        // keyboardType: TextInputType.numberWithOptions(
                        //   signed: true,
                        //   decimal: true,

                        // ),
                        onSaved: (PhoneNumber number) {
                          print('On Saved: $number');
                        },
                      ),
                      Gap(kPadding + 10),
                      Row(
                        children: [
                          Expanded(
                            child: CustomBookingButtom(
                              color: BAppColor.kCheckOutInActiveBgColor,
                              btnText: "Cancel",
                              textcolor: BAppColor.kCheckOutActiveTextColor,
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Gap(kPadding),
                          Expanded(
                            child: CustomBookingButtom(
                              btnText: "Book Now",
                              onTap: () {
                                log("DateTime ${selectedDateTime}}");
                                home.makeBookingService(
                                  service: widget.serProvider,
                                  dateTime: selectedDateTime.toString(),
                                  phone: _phoneController.text,
                                );
                              },
                              // home.makeBookingService(widget.serProvider),
                              color: BAppColor.kPrimaryColor,
                              textcolor: BAppColor.kbgColor,
                            ),
                          ),

                          // ElevatedButton(
                          //   onPressed: () {
                          //     if (_formKey.currentState!.validate()) {
                          //       _formKey.currentState!.save();
                          //       Navigator.of(context).pop();
                          //       _processPayment(context, _controller.text);
                          //     }
                          //   },
                          //   child: Text('Proceed to Payment'),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomBookingButtom extends StatelessWidget {
  const CustomBookingButtom({
    super.key,
    required this.btnText,
    this.onTap,
    required this.color,
    required this.textcolor,
  });

  final String btnText;
  final Color color;
  final Color textcolor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          btnText,
          style: TextStyle(
            color: textcolor,
            fontSize: 17,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
