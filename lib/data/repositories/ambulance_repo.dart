import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../core/class/enums.dart';
import '../../core/error/exception.dart';
import '../../core/functions/ckeck_internet.dart';
import '../../core/functions/show_errormessage.dart';
import '../dataSoureces/localDataSource/ambulance_localdata.dart';
import '../dataSoureces/remoteDataSource/ambulance_remotdata.dart';
import '../model/ambulance_model.dart';

abstract class AmbulanceRepo {
  Future<Either<StatusRequest, AmbulanceModelList>> getAllAmbulance();
}

class AmbulanceRepoImpHttp implements AmbulanceRepo {
  final AmbulanceRemotDataImpHttp ambulanceRemotData;
  final AmbulanceLocalDataImp ambulanceLocalData;
  AmbulanceRepoImpHttp({
    required this.ambulanceRemotData,
    required this.ambulanceLocalData,
  });

  @override
  Future<Either<StatusRequest, AmbulanceModelList>> getAllAmbulance() async {
    if (await ckeckInternet()) {
      try {
        final remotData = await ambulanceRemotData.getAllAmbulance();
        ambulanceLocalData.cacheAmbulance(remotData);

        log('from Server  ==> Ambulance Data   ');

        return right(remotData);
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return left(StatusRequest.serverFailure);
      }
    } else {
      try {
        final localData = await ambulanceLocalData.getCachedAmbulance();
        log('from Cache  <== Ambulance Data');
        return right(localData);
      } on EmptyCacheException {
        showNetworkError();

        return left(StatusRequest.noData);
      }
    }
  }
}
