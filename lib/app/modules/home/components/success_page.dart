import 'package:ewash/app/modules/booking/views/booking_view.dart';
import 'package:ewash/app/modules/home/controllers/home_controller.dart';
import 'package:ewash/utils/constants/reusable_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../utils/constants/app_colors.dart';
import 'transaction_card.dart';

class SucessBookingPage extends StatelessWidget {
  const SucessBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? BAppColor.kCardDarkbgColor : Colors.white,
        leading: backArrow(),
        elevation: 0,
        title: Text(
          "Transaction Receipe",
          style: style(
            fontSize: 16,
            color: isDarkMode ? BAppColor.kbgColor : BAppColor.kTextStyleColor,
          ),
        ),
        centerTitle: true,
        actions: [],
      ),
      body: SingleChildScrollView(
        child: GetBuilder<HomeController>(
          builder: (ho) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  TransactionInfoCardWidget(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? BAppColor.kCardDarkbgColor.withOpacity(0.45)
                                : Color(0xffF1F1F1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Leave review",
                            style: style(
                              fontSize: 16,
                              color: isDarkMode
                                  ? BAppColor.kbgColor
                                  : BAppColor.kTextStyleColor,
                            ),
                          ),
                        ),
                      ),
                      Gap(kPadding + 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              () => BookingView(),
                              transition: Transition.fade,
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            decoration: BoxDecoration(
                              color: BAppColor.kPrimaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "View My Bookings",
                              style: style(
                                fontSize: 16,
                                color: BAppColor.kbgColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
