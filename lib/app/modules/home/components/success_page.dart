import 'package:ewash/utils/constants/reusable_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../utils/constants/app_colors.dart';

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
          "Transaction Success",
          style: style(
            fontSize: 16,
            color: isDarkMode ? BAppColor.kbgColor : BAppColor.kTextStyleColor,
          ),
        ),
        centerTitle: true,
        actions: [],
      ),
      body: Center(
        child: Text("Success waaye"),
      ),
    );
  }
}
