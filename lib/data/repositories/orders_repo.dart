import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../core/class/enums.dart';
import '../../core/constant/string.dart';
import '../../core/error/exception.dart';
import '../../core/functions/ckeck_internet.dart';
import '../../core/functions/show_coustom_snackbar.dart';
import '../../core/functions/show_errormessage.dart';
import '../dataSoureces/remoteDataSource/orders_remotdata.dart';
import '../model/order_model.dart';

abstract class OrdersRepo {
  Future<bool> addOrder({required OrderModel order});
  Future<bool> cancelOrder({required orderId});
  Future<Either<StatusRequest, List<OrderModel>>> getAllOrders(
      {required userId});
}

class OrderRepoImpHttp implements OrdersRepo {
  final OrderRemotDataImpHttp orderRemotData;

  OrderRepoImpHttp({required this.orderRemotData});

  @override
  Future<bool> addOrder({required OrderModel order}) async {
    if (await ckeckInternet()) {
      try {
        await orderRemotData.postOrder(body: order.toJson());

        log('to Server  ==> addOrder Data   ');
        showCustomSnackBar(message: "order addd", title: Done.tr);
        return true;
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return false;
      }
    } else {
      showNetworkError();
      return false;
    }
  }

  @override
  Future<Either<StatusRequest, List<OrderModel>>> getAllOrders(
      {required userId}) async {
    if (await ckeckInternet()) {
      try {
        final remotData = await orderRemotData.getOrder(userId: userId);

        log('from Server  ==> getAllOrders Data   ');

        return right(remotData);
      } on ServerException catch (_) {
        return left(StatusRequest.serverFailure);
      }
    } else {
      showNetworkError();
      return left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<bool> cancelOrder({required orderId}) async {
    if (await ckeckInternet()) {
      try {
        await orderRemotData.cancelOrder(orderId: orderId);

        log('to Server  ==> deletOrder   ');

        return true;
      } on ServerException catch (_) {
        showCustomSnackBar(
            message: Please_try_agein_later.tr,
            title: Unexpected_Error.tr,
            isError: true);
        return false;
      }
    } else {
      showNetworkError();
      return false;
    }
  }
}
