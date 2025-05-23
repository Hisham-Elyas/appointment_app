import 'package:get/get.dart';

class ApiClent extends GetConnect implements GetxService {
  ApiClent();

  Future<Response> getData({required String uri}) async {
    try {
      // await Future.delayed(const Duration(seconds: 5)); // used in llocalhost
      Response response = await get(uri);
      // print('========================errror===========================');
      // print(response.statusText);
      return response;
    } catch (e) {
      // print(e);
      // print('========================errror===========================');
      rethrow;
      // return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> posData({required String uri, required dynamic body}) async {
    try {
      // await Future.delayed(const Duration(seconds: 5));// used in llocalhost
      Response response = await post(uri, body);
      // print(response.toString());
      return response;
    } catch (e) {
      // print(e.toString());
      // print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> updateData(
      {required String uri, required dynamic body}) async {
    try {
      // await Future.delayed(const Duration(seconds: 5));// used in llocalhost
      Response response = await patch(uri, body);
      // print(response.toString());
      return response;
    } catch (e) {
      // print(e.toString());
      // print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteData({required String uri}) async {
    try {
      // await Future.delayed(const Duration(seconds: 5)); // used in llocalhost
      Response response = await delete(uri);
      // print(response.toString());
      return response;
    } catch (e) {
      // print(e.toString());
      // print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
