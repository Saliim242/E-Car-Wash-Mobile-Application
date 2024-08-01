import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../utils/constants/api_or_keys_constants.dart';
import '../../../utils/constants/app_colors.dart';
import '../../routes/app_pages.dart';

class GetStartBtn extends StatefulWidget {
  const GetStartBtn({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<GetStartBtn> createState() => _GetStartBtnState();
}

class _GetStartBtnState extends State<GetStartBtn> {
  bool isLoading = false;
  final box = GetStorage();
  loadingHandler() {
    box.write(onboarding, true);
    setState(
      () {
        isLoading = true;
        Future.delayed(const Duration(seconds: 3)).then(
          (value) {
            isLoading = false;
            Get.offNamed(Routes.USER);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loadingHandler,
      child: Container(
        margin: const EdgeInsets.only(top: 60),
        width: widget.size.width / 1.5,
        height: widget.size.height / 15,
        decoration: BoxDecoration(
          color: BAppColor.kPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isLoading
              ? const Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : Text(
                  "Get Started now",
                  style: style(
                    fontSize: 17,
                    color: BAppColor.kbgColor,
                  ),
                ),
        ),
      ),
    );
  }
}

class SkipBtn extends StatelessWidget {
  const SkipBtn({
    Key? key,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  final Size size;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      width: size.width / 1.5,
      height: size.height / 15,
      decoration: BoxDecoration(
          border: Border.all(
            color: BAppColor.kPrimaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: onTap,
        splashColor: BAppColor.kPrimaryColor,
        child: Center(
          child: Text(
            "Skip",
            style: style(
              fontSize: 17,
              color: BAppColor.kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
