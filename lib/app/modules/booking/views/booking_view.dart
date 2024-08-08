import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ewash/app/modules/booking/model/user_bookings_model.dart';
import 'package:ewash/utils/constants/reusable_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../components/custom_error.dart';
import '../controllers/booking_controller.dart';

class BookingView extends StatefulWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    return GetBuilder<BookingController>(
      builder: (booking) {
        return RefreshIndicator(
          onRefresh: () async {
            booking.userBookings();
          },
          child: Scaffold(
            appBar: AppBar(
              leading: backArrow(),
              elevation: 0,
              backgroundColor:
                  isDarkMode ? BAppColor.kCardDarkbgColor : Colors.white,
              title: Text(
                "Your Booking Details",
                style: style(
                  fontSize: 16,
                  color: isDarkMode
                      ? BAppColor.kbgColor
                      : BAppColor.kTextStyleColor,
                ),
              ),
              centerTitle: true,
            ),
            body: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(kPadding),
                            GetBuilder<BookingController>(
                              builder: (boking) {
                                if (boking.isBookingLoading) {
                                  return ListView.builder(
                                    itemCount: 8,
                                    physics: NeverScrollableScrollPhysics(),
                                    // scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return BookingLoading();
                                    },
                                  );
                                } else if (boking.booking.isEmpty) {
                                  return CustomEmplyScreen(
                                      img: 'assets/animations/empty.json',
                                      //Oops! Your Favorites List is Feeling a Bit Empty! 🌟
                                      content:
                                          "It looks like you haven't booked a service. Start your first booking today and let the magic begin!"
                                      // 'Start adding your dream Service Provider to create your own personalized collection and let the magic begin!',
                                      );
                                }

                                return SizedBox(
                                  //height: MediaQuery.of(context).size.height * 0.058,
                                  child: ListView.builder(
                                    itemCount: boking.booking.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    // scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return MyBookingCard(
                                        serProvider: boking.booking[index],
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await Get.find<BookingController>().userBookings();
  }
}

class MyBookingCard extends StatelessWidget {
  const MyBookingCard({super.key, required this.serProvider});
  final UserBookingsModel serProvider;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    bool isPortrait = BReusableConstants.isPortrait(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
      decoration: BoxDecoration(
        color: isDarkMode
            ? BAppColor.kCardDarkbgColor //Theme.of(context).cardColor
            : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Service Status
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      horizontal: kPadding + 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: serProvider.status == "active"
                        ? isDarkMode
                            ? BAppColor.kDarkSecondColor
                            : BAppColor.kcheckInInActiveBgColor
                        : isDarkMode
                            ? BAppColor.kDarkSecondColor
                            : BAppColor.kCheckOutInActiveBgColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: AutoSizeText(
                    "${serProvider.status}",
                    style: style(
                      fontSize: 14,
                      color: serProvider.status == "active"
                          ? isDarkMode
                              ? BAppColor.kbgColor.withOpacity(0.65)
                              : BAppColor.kCheckInActiveTextColor
                          : isDarkMode
                              ? BAppColor.kbgColor.withOpacity(0.65)
                              : BAppColor.kCheckOutActiveTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Gap(kPadding),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      horizontal: kPadding + 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: serProvider.paymentStatus == "paid"
                        ? isDarkMode
                            ? BAppColor.kDarkSecondColor
                            : BAppColor.kcheckInInActiveBgColor
                        : isDarkMode
                            ? BAppColor.kDarkSecondColor
                            : BAppColor.kCheckOutInActiveBgColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: AutoSizeText(
                    "${serProvider.paymentStatus}",
                    style: style(
                      fontSize: 14,
                      color: serProvider.paymentStatus == "paid"
                          ? isDarkMode
                              ? BAppColor.kbgColor.withOpacity(0.65)
                              : BAppColor.kCheckInActiveTextColor
                          : isDarkMode
                              ? BAppColor.kbgColor.withOpacity(0.65)
                              : BAppColor.kCheckOutActiveTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          Gap(kPadding - 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Align(
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    imageUrl:
                        "${serProvider.service!.image ?? "https://craftsnippets.com/articles_images/placeholder/placeholder.jpg"}",
                    // "https://craftsnippets.com/articles_images/placeholder/placeholder.jpg",
                    fit: BoxFit.cover,
                    width: isPortrait
                        ? MediaQuery.of(context).size.height * 0.12
                        : MediaQuery.of(context).size.height * 0.3,
                    height: isPortrait
                        ? MediaQuery.of(context).size.height * 0.12
                        : MediaQuery.of(context).size.height * 0.3,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor:
                          isDarkMode ? Color(0xff3f3f3f) : Colors.grey[400]!,
                      highlightColor:
                          isDarkMode ? Colors.white10 : Colors.grey[300]!,
                      child: Container(
                        width: MediaQuery.of(context).size.height * 0.11,
                        height: MediaQuery.of(context).size.height * 0.11,
                        decoration: BoxDecoration(
                          color: Theme.of(context).hoverColor.withOpacity(0.25),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => CachedNetworkImage(
                      imageUrl:
                          "https://craftsnippets.com/articles_images/placeholder/placeholder.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Gap(kPadding - 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(kPadding),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: kPadding + 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? BAppColor.kDarkSecondColor
                            : BAppColor.kPrimaryColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: AutoSizeText(
                        "${serProvider.service?.serviceType?.name ?? ""}",
                        style: style(
                          fontSize: 14,
                          color: isDarkMode
                              ? BAppColor.kbgColor.withOpacity(0.75)
                              : BAppColor.kPrimaryColor,
                        ),
                      ),
                    ),
                    Gap(kPadding - 10),
                    AutoSizeText(
                      "${serProvider.service?.carType?.type ?? ""}",
                      style: style(
                        fontSize: 15,
                        color: isDarkMode
                            ? BAppColor.kbgColor.withOpacity(0.75)
                            : BAppColor.kTextStyleColor,
                      ),
                    ),
                    Gap(kPadding - 10),
                    AutoSizeText(
                      "${serProvider.service?.description ?? ""}",
                      style: style(
                        fontSize: 14,
                        color: isDarkMode
                            ? BAppColor.kbgColor.withOpacity(0.75)
                            : BAppColor.kTextStyleColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(kPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BookingInfo(
                isDarkMode: isDarkMode,
                title: "Booking ID",
                subtitle: "${serProvider.tn?.substring(0, 7) ?? ""}",
              ),
              BookingInfo(
                isDarkMode: isDarkMode,
                title: "Booking Date",
                subtitle: "${DateFormat('d MMM HH:mm a').format(
                  DateTime.parse(
                    serProvider.dateTime.toString(),
                  ),
                )}",
              ),
              BookingInfo(
                isDarkMode: isDarkMode,
                title: "Total Payments",
                subtitle: "\$${serProvider.amount}",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BookingLoading extends StatelessWidget {
  const BookingLoading({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    bool isPortrait = BReusableConstants.isPortrait(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: isDarkMode ? BAppColor.kCardDarkbgColor : Colors.grey[100]!,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Shimmer.fromColors(
        baseColor: isDarkMode ? BAppColor.kDarkSecondColor : Colors.grey[300]!,
        highlightColor: isDarkMode
            ? BAppColor.kSecondColor.withOpacity(0.45)
            : Colors.grey[100]!,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Service Status
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: kPadding + 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Gap(kPadding),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: kPadding + 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(kPadding - 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey,
                      ),
                      width: isPortrait
                          ? MediaQuery.of(context).size.height * 0.12
                          : MediaQuery.of(context).size.height * 0.3,
                      height: isPortrait
                          ? MediaQuery.of(context).size.height * 0.12
                          : MediaQuery.of(context).size.height * 0.3,
                    ),
                  ),
                  Gap(kPadding - 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(kPadding),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Gap(kPadding - 10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Gap(kPadding - 10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(kPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 100,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      Gap(kPadding - 10),
                      Container(
                        width: 80,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 100,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      Gap(kPadding - 10),
                      Container(
                        width: 80,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 100,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      Gap(kPadding - 10),
                      Container(
                        width: 80,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingInfo extends StatelessWidget {
  const BookingInfo({
    super.key,
    required this.isDarkMode,
    required this.title,
    required this.subtitle,
  });

  final bool isDarkMode;

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AutoSizeText(
          "${title}",
          style: style(
            fontSize: 14,
            color: isDarkMode
                ? BAppColor.kbgColor.withOpacity(0.75)
                : BAppColor.kTextStyleColor,
          ),
        ),
        AutoSizeText(
          "${subtitle}",
          style: style(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDarkMode
                ? BAppColor.kbgColor.withOpacity(0.75)
                : BAppColor.kTextStyleColor,
          ),
        ),
      ],
    );
  }
}
