import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';

import '../core/class/enums.dart';
import '../core/constant/string.dart';
import '../core/functions/show_coustom_snackbar.dart';
import '../core/services/services.dart';
import '../data/model/drugs_model.dart';
import '../data/model/drugs_model/product.dart';
import '../data/repositories/drugs_repo.dart';
import 'location_controller.dart';

class DrugsController extends GetxController {
  final DrugsRepoImpHttp drugsRepo = Get.find();
  final MyServices myServ = Get.find();

  DrugsModel? drigsData2;
  List<Product> cartDrigs = [];

  final List<Product> randDrugsList = [];
  Map<String, Product> favoriteDrug = {};

  late StatusRequest statusReq;
  @override
  void onInit() async {
    super.onInit();

    final cachedCart = myServ.sharedPreferences.getString('MY_CART');
    final cachedFavDrug = myServ.sharedPreferences.getString('MY_FAV_DRUGS');
    if (cachedCart != null) {
      final List cart = jsonDecode(cachedCart);
      cartDrigs = cart.map((e) => Product.fromJson(e)).toList();
    }
    if (cachedFavDrug != null) {
      final Map favDrug = jsonDecode(cachedFavDrug);
      favoriteDrug = favDrug.map((key, value) {
        return MapEntry(key, Product.fromJson(value));
      });
    }
    await getAllDrougs();
  }

  void checkout() {
    LocationController locationController = Get.find();
    if (cartDrigs.isEmpty) {
      showCustomSnackBar(
          message: You_should_at_least_add_an_item_in_the_cart.tr,
          title: Cart.tr,
          isError: true);
      return;
    }
    locationController.selectAddress();
  }

  Future<void> getAllDrougs() async {
    statusReq = StatusRequest.loading;
    update();
    final dataD = await drugsRepo.getAllData();
    dataD.fold((l) {
      statusReq = l;
      update();
    }, (r) {
      drigsData2 = null;
      drigsData2 = r.value1;
      statusReq = r.value2;
      randDrugs(10);
      update();
    });
  }

  void addTofavorite(Product drug) {
    if (favoriteDrug.containsKey(drug.id)) {
      favoriteDrug.removeWhere((key, value) => key == drug.id);
      myServ.sharedPreferences
          .setString('MY_FAV_DRUGS', jsonEncode(favoriteDrug));

      update();
    } else {
      favoriteDrug.addAll({drug.id!: drug});
      myServ.sharedPreferences
          .setString('MY_FAV_DRUGS', jsonEncode(favoriteDrug));
      update();
    }
  }

  bool isFavorite(Product drug) {
    if (favoriteDrug.containsKey(drug.id)) {
      return true;
    } else {
      return false;
    }
  }

  List<Product> randDrugs(int count) {
    for (var i = 0; i < count; i++) {
      randDrugsList
          .add(drigsData2!.product![Random().nextInt(drigsData2!.count!)]);
    }
    update();
    return randDrugsList;
  }

  List<Product>? filter(String query) {
    List<Product>? filter = [];

    if (query == "") {
      return drigsData2?.product;
    } else {
      filter = drigsData2?.product!.where((element) {
        return element.name!.toUpperCase().startsWith(query.toUpperCase());
      }).toList();
      return filter;
    }
  }

  void addToCart(Product drigsinfo) {
    if (cartDrigs.contains(drigsinfo)) {
      showCustomSnackBar(
          title: Drugs_Item.tr,
          message: Already_added_to_cart.tr,
          isError: true);
    } else {
      showCustomSnackBar(title: Drugs_Item.tr, message: add_to_cart.tr);

      cartDrigs.add(drigsinfo);
      myServ.sharedPreferences.setString('MY_CART', jsonEncode(cartDrigs));
    }
  }

  void deleteFromCart(drigsinfo) {
    if (cartDrigs.contains(drigsinfo)) {
      cartDrigs.removeWhere((element) => element == drigsinfo);
      myServ.sharedPreferences.setString('MY_CART', jsonEncode(cartDrigs));

      update();
    }
  }

  void deleteAllCart() {
    cartDrigs.clear();
    myServ.sharedPreferences.remove('MY_CART');

    update();
  }

  void deleteAllFav() {
    favoriteDrug.clear();
    myServ.sharedPreferences.remove('MY_FAV_DRUGS');

    update();
  }
}
