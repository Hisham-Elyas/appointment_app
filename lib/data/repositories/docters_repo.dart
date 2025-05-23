// import 'dart:developer';

// import 'package:dartz/dartz.dart';

// import '../../core/class/enums.dart';
// import '../../core/error/exception.dart';
// import '../../core/functions/ckeck_internet.dart';
// import '../../core/functions/show_errormessage.dart';
// import '../dataSoureces/localDataSource/doctors_localdata.dart';
// import '../dataSoureces/remoteDataSource/doctors_remotdata.dart';
// import '../model/doctor_model.dart';

// abstract class DoctorsRepo {
//   Future<Either<StatusRequest, DoctorModel>> getAllDoctors();

//   // findDoctor();
// }

// class DoctorsRepoImpHttp implements DoctorsRepo {
//   final DoctorsRemotDataImpHttp doctorsRemotData;
//   final DoctorsLocalDataImp doctorsLocalData;
//   DoctorsRepoImpHttp({
//     required this.doctorsRemotData,
//     required this.doctorsLocalData,
//   });

//   @override
//   Future<Either<StatusRequest, DoctorModel>> getAllDoctors() async {
//     if (await ckeckInternet()) {
//       try {
//         final remotData = await doctorsRemotData.getAllDoctors();
//         doctorsLocalData.cacheDoctors(remotData);

//         log('from Server  ==> doctors Data   ');

//         return right(remotData);
//       } on ServerException catch (e) {
//         showErrorMessage(e.message);

//         return left(StatusRequest.serverFailure);
//       }
//     } else {
//       try {
//         final localData = await doctorsLocalData.getCachedDoctors();
//         log('from Cache  <== doctors Data');
//         return right(localData);
//       } on EmptyCacheException {
//         showNetworkError();

//         return left(StatusRequest.noData);
//       }
//     }
//   }
// }
