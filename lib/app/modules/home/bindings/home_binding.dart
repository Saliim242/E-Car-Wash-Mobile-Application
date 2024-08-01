import 'package:ewash/app/modules/favorate/controllers/favorate_controller.dart';
import 'package:get/get.dart';

import '../../user/controllers/user_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.put<UserController>(UserController(), permanent: true);
    Get.put<FavorateController>(FavorateController(), permanent: true);
  }
}
