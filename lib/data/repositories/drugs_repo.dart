import 'dart:developer';

import '../../core/error/exception.dart';
import 'package:dartz/dartz.dart';

import '../../core/class/enums.dart';
import '../../core/functions/ckeck_internet.dart';
import '../../core/functions/show_errormessage.dart';
import '../dataSoureces/localDataSource/durgs_localdata.dart';
import '../dataSoureces/remoteDataSource/durgs_remotdata.dart';
import '../model/drugs_model.dart';
import '../model/drugs_model/product.dart';

abstract class DrugsRepo {
  Future<Either<StatusRequest, Tuple2<DrugsModel, StatusRequest>>> getAllData();
  Future<Either<Unit, DrugsModel>> searchByName({required String name});
  Future<Either<Unit, Product>> findById({required String id});
  // Future<DrugsModel> getRandData({required int limet});
}

class DrugsRepoImpHttp implements DrugsRepo {
  final DrugsRemotDataImpHttp drugsRemotData;
  final DrugsLocalDataImp drugslocalData;
  DrugsRepoImpHttp({
    required this.drugsRemotData,
    required this.drugslocalData,
  });

  @override
  Future<Either<StatusRequest, Tuple2<DrugsModel, StatusRequest>>>
      getAllData() async {
    if (await ckeckInternet()) {
      try {
        final remotData = await drugsRemotData.getAllData();
        drugslocalData.cacheDurgs(remotData);

        log('from Server ==> drugs Data ');

        return right(Tuple2(remotData, StatusRequest.success));
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return left(StatusRequest.serverFailure);
      }
    } else {
      try {
        final localData = await drugslocalData.getCachedDurgs();
        log('from Cache <==  drugs Data');
        return right(Tuple2(localData, StatusRequest.success));
      } on EmptyCacheException {
        showNetworkError();

        return left(StatusRequest.serverFailure);
      }
    }
  }

  @override
  Future<Either<Unit, Product>> findById({required String id}) async {
    if (await ckeckInternet()) {
      try {
        final Product drug = await drugsRemotData.findById(id: id);

        return right(drug);
      } on ServerException catch (e) {
        showErrorMessage(e.message);
        return left(unit);
      }
    } else {
      showNetworkError();
      return left(unit);
    }
  }

  @override
  Future<Either<Unit, DrugsModel>> searchByName({required String name}) async {
    if (await ckeckInternet()) {
      try {
        final DrugsModel drugs = await drugsRemotData.searchByName(name: name);

        return right(drugs);
      } on ServerException catch (e) {
        showErrorMessage(e.message);
        return left(unit);
      }
    } else {
      showNetworkError();
      return left(unit);
    }
  }
}
