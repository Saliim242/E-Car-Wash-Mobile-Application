import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../home/model/services_providers_model.dart';

class FavorateController extends GetxController {
  final box = GetStorage();
  final String kServiceFavorite = "kServiceProviders";

  List<ServiceProvidersModel> favoriteServices = [];

  int get favoriteLength => favoriteServices.length;

  // check if the Services is already in the favoraties

  bool checkServicesInFavorite(ServiceProvidersModel pro) {
    bool isLiked = false;
    for (ServiceProvidersModel item in favoriteServices) {
      if (item.sId == pro.sId) {
        isLiked = true;
      }
    }

    return isLiked;
  }

  // get all Properties Favorites

  Future<void> getServicesFavorites() async {
    if (box.hasData(kServiceFavorite)) {
      var data = await box.read(kServiceFavorite);

      for (var p in data) {
        favoriteServices.add(
          ServiceProvidersModel.fromJson(Map<String, dynamic>.from(p)),
        );
      }

      update();
    }
  }

  // remove favorite from the list

  Future<void> removeFavoriteServices(ServiceProvidersModel pro) async {
    favoriteServices.removeWhere((e) => e.sId == pro.sId);
    update();
    final products = favoriteServices.map((v) => v.toJson()).toList();
    await box.remove(kServiceFavorite);
    await box.write(kServiceFavorite, products);
  }

  //  Clear All Favorites

  // SAVE NEW PROPERTIES
  Future<void> saveFavoriteServices(ServiceProvidersModel pro) async {
    favoriteServices.add(pro);
    update();
    final products = favoriteServices.map((v) => v.toJson()).toList();
    await box.write(kServiceFavorite, products);
  }

  @override
  void onInit() {
    super.onInit();

    getServicesFavorites();
  }
}
