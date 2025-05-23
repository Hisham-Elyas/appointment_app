import '../../../core/constant/string.dart';

import '../../../core/class/api_client.dart';
import '../../../core/error/exception.dart';
import '../../model/drugs_model.dart';
import '../../model/drugs_model/product.dart';

abstract class DrugsRemotData {
  getAllData();
  getRandData({required int limet});
  Future<Product> findById({required String id});
  Future<DrugsModel> searchByName({required String name});
}

class DrugsRemotDataImpHttp implements DrugsRemotData {
  final ApiClent apiClent;
  DrugsRemotDataImpHttp({required this.apiClent});
  @override
  Future<DrugsModel> getAllData() async {
    final resalt = await apiClent.getData(uri: '$AppURl$DRUGS');
    if (resalt.statusCode == 200) {
      return DrugsModel.fromJson(resalt.body);
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<DrugsModel> getRandData({required int limet}) async {
    final resalt =
        await apiClent.getData(uri: '$AppURl$DRUGS$RandomProduct/$limet');

    if (resalt.statusCode == 200) {
      return DrugsModel.fromJson(resalt.body);
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<Product> findById({required String id}) async {
    final resalt = await apiClent.getData(uri: '$AppURl$DRUGS/$id');

    if (resalt.statusCode == 200) {
      return Product.fromJson(resalt.body['product']);
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<DrugsModel> searchByName({required String name}) async {
    final resalt = await apiClent.getData(uri: '$AppURl$DRUGS/$name');
    if (resalt.statusCode == 200) {
      return DrugsModel.fromJson(resalt.body);
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }
}
