import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../core/class/enums.dart';
import '../../core/error/exception.dart';
import '../../core/functions/ckeck_internet.dart';
import '../../core/functions/show_errormessage.dart';
import '../dataSoureces/localDataSource/hospital_localdata.dart';
import '../dataSoureces/remoteDataSource/hospital_remotdata.dart';
import '../model/hospital_model.dart';

abstract class HospitalRepo {
  Future<Either<StatusRequest, HospitalModelList>> getAllHospital();
}

class HospitalRepoImpHttp implements HospitalRepo {
  final HospitalRemotDataImpHttp hospitalRemotData;
  final HospitalLocalDataImp hospitalLocalData;
  HospitalRepoImpHttp({
    required this.hospitalLocalData,
    required this.hospitalRemotData,
  });

  @override
  Future<Either<StatusRequest, HospitalModelList>> getAllHospital() async {
    if (await ckeckInternet()) {
      try {
        final remotData = await hospitalRemotData.getAllHospital();
        hospitalLocalData.cacheHospital(remotData);

        log('from Server  ==> Hospital Data   ');

        return right(remotData);
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return left(StatusRequest.serverFailure);
      }
    } else {
      try {
        final localData = await hospitalLocalData.getCachedHospital();
        log('from Cache  <== Hospital Data');
        return right(localData);
      } on EmptyCacheException {
        showNetworkError();

        return left(StatusRequest.noData);
      }
    }
  }
}
