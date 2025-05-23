import 'dart:convert';

import '../core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/enums.dart';
import '../core/constant/string.dart';
import '../data/model/location_model.dart';
import '../data/model/order_model.dart';
import '../data/repositories/orders_repo.dart';
import 'drugs_controller.dart';
import 'user_controller.dart';

class OrderController extends GetxController {
  final OrderRepoImpHttp orderRepoImpHttp = Get.find();
  UserController userInfoController = Get.find();
  DrugsController drugsController = Get.find();
  MyServices serv = Get.find();
  List<OrderModel> orderHistory = [];
  List<OrderModel> ordersOngoing = [];
  PageController pagecontroller = PageController();
  StatusRequest statusRequest = StatusRequest.loading;
  final List<String> taps = [
    Ongoing,
    History,
  ];

  int tapLIstNum = 0;

  set setTapLIstNum(val) {
    tapLIstNum = val;
    pagecontroller.animateToPage(val,
        duration: const Duration(milliseconds: 700),
        curve: Curves.fastOutSlowIn);
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    await getAllOrders();
  }

  Color statusColor(Status status) {
    switch (status) {
      case Status.pending:
        return Colors.blueGrey;
      case Status.underway:
        return Colors.blue;
      case Status.delivered:
        return const Color(0xff7beb78);
      case Status.cancel:
        return Colors.grey;
      case Status.closed:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future<void> cancelOrders({required String orderId}) async {
    final bool data = await orderRepoImpHttp.cancelOrder(orderId: orderId);
    if (data) {
      // ordersOngoing.removeAt(index);
      // update();
      getAllOrders();
    }
  }

  Future<void> getAllOrders() async {
    statusRequest = StatusRequest.loading;
    update();
    final data = await orderRepoImpHttp.getAllOrders(
        userId: userInfoController.userInf.userId);
    data.fold((l) {
      statusRequest = l;
    }, (r) {
      orderHistory.clear();
      ordersOngoing.clear();
      for (var element in r) {
        if (element.status! == Status.pending ||
            element.status! == Status.underway) {
          ordersOngoing.add(element);
        } else {
          orderHistory.add(element);
        }
      }
      ordersOngoing.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      orderHistory.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));

      statusRequest = StatusRequest.success;
    });
    update();
  }

  void ordering({required LocationModel location}) async {
    final OrderModel newOrder = OrderModel(
      userId: userInfoController.userInf.userId,
      userInfo: userInfoController.userInf,
      userLocation: location,
      listProduct:
          drugsController.cartDrigs.map((element) => element.name).toList(),
    );

    /// send newOrder to Server
    final bool isOk = await orderRepoImpHttp.addOrder(order: newOrder);
    if (isOk) {
      // await addToCartHistoryList(orderList: orderHistory);
      drugsController.deleteAllCart();
      Get.close(1);
    }
  }

  Future<void> addToCartHistoryList(
      {required List<OrderModel> orderList}) async {
    await serv.sharedPreferences
        .setString("CART_HISTORY_LIST", jsonEncode(orderList));
  }

  void getCartHistoryList() {
    final cachedCartHistory =
        serv.sharedPreferences.getString("CART_HISTORY_LIST");
    if (cachedCartHistory != null) {
      final List cart = jsonDecode(cachedCartHistory);
      orderHistory = cart.map((e) => OrderModel.fromJson(e)).toList();
    }
  }

  void clearCartHistory() {
    serv.sharedPreferences.remove("CART_HISTORY_LIST");
  }
}
