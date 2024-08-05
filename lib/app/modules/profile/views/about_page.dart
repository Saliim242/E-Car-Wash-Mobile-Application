import 'package:ewash/utils/constants/reusable_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';

import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../utils/constants/app_colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? BAppColor.kCardDarkbgColor : Colors.white,
        leading: backArrow(),
        elevation: 0,
        title: Text(
          "About us",
          style: style(
            fontSize: 16,
            color: isDarkMode
                ? BAppColor.kbgColor.withOpacity(0.75)
                : BAppColor.kTextStyleColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(kPadding),
              Text(
                "Who we are:",
                style: style(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? BAppColor.kbgColor.withOpacity(0.75)
                      : BAppColor.kTextStyleColor,
                ),
              ),
              Gap(kPadding * 2),
              Text(
                "At our carwash, we offer a range of services to keep your vehicle looking its best. Our team of skilled professionals is dedicated to providing top-notch care for your vehicle, ensuring it stays clean, shiny, and protected. From thorough washes to specialized treatments, we have everything you need to maintain the beauty and value of your car. Discover the difference with our premium services :",
                style: style(
                  fontSize: 16,
                  color: isDarkMode
                      ? BAppColor.kbgColor.withOpacity(0.75)
                      : BAppColor.kTextStyleColor,
                ),
              ),
              buildServiceTile(
                icon: Icons.local_car_wash,
                title: 'Polishing',
                description:
                    'Restore the shine to your vehicle with our professional polishing services.',
                isDarkMode: isDarkMode,
              ),
              buildServiceTile(
                icon: Icons.bubble_chart,
                title: 'Foaming',
                description:
                    'Experience a deep clean with our foaming service, removing dirt and grime from every surface.',
                isDarkMode: isDarkMode,
              ),
              buildServiceTile(
                icon: Icons.build,
                title: 'Oil Change',
                description:
                    'Keep your engine running smoothly with our oil change services, performed by trained technicians.',
                isDarkMode: isDarkMode,
              ),
              Gap(kPadding),
              Text(
                'Contact Us:',
                style: style(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? BAppColor.kbgColor.withOpacity(0.75)
                      : BAppColor.kTextStyleColor,
                ),
              ),
              Gap(kPadding),
              ContactWidget(
                icon: IconlyBroken.location,
                text: 'KM4 TaleexStreet,Mogadishu, Somalia',
              ),
              Gap(kPadding),
              ContactWidget(
                icon: IconlyBroken.calling,
                text: '+252 613114335',
              ),
              Gap(kPadding),
              ContactWidget(
                icon: IconlyBroken.message,
                text: 'ewashcenter@gmail.com',
              ),
              Gap(kPadding),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: isDarkMode ? BAppColor.kCardDarkbgColor : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isDarkMode
                ? BAppColor.kbgColor.withOpacity(0.75)
                : BAppColor.kPrimaryColor,
          ),
          Gap(kPadding - 6),
          Text(
            text,
            style: style(
              fontSize: 13.0,
              color: isDarkMode
                  ? BAppColor.kbgColor
                  : BAppColor.kTextStyleColor.withOpacity(0.75),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

Widget buildServiceTile({
  required IconData icon,
  required String title,
  required String description,
  required bool isDarkMode,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10.0),
    decoration: BoxDecoration(
      color: isDarkMode ? BAppColor.kCardDarkbgColor : Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
    padding: EdgeInsets.all(16.0),
    child: Row(
      children: [
        Icon(
          icon,
          size: 32.0,
          color: isDarkMode
              ? BAppColor.kbgColor.withOpacity(0.75)
              : BAppColor.kTextStyleColor,
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: style(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? BAppColor.kbgColor.withOpacity(0.75)
                      : BAppColor.kTextStyleColor.withOpacity(0.75),
                  //Color(0xFF4713A3)
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                description,
                style: style(
                  fontSize: 14.0,
                  color: isDarkMode
                      ? BAppColor.kbgColor
                      : BAppColor.kTextStyleColor.withOpacity(0.75),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
