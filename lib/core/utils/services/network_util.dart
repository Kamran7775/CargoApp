import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:safe_express_cargo_app/core/utils/services/urls.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/cargo_list_response_model.dart';
import '../../../model/couriers_list_response_model.dart';
import '../../../model/get_deliveries_response_model.dart';
import '../../../model/login_request_model.dart';
import '../../../model/package_list_model.dart';

class WebService {
  static singIn(LoginRequestModel loginRequestModel) async {
    final prefs = await SharedPreferences.getInstance();
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    try {
      final response = await dio.post(Urls.LOGIN_URL, data: loginRequestModel);
      if (response.statusCode == HttpStatus.ok) {
        await prefs.setString('Authorization', '${response.data['access']}');
        return true;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<List<CargoListResponseModel>> getCargoCompaniesList() async {
    final prefs = await SharedPreferences.getInstance();
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    try {
      final response = await dio.get(Urls.CARGO_LIST_URL);
      if (response.statusCode == HttpStatus.ok) {
        List jsonResponse = response.data;
        return jsonResponse
            .map((results) => CargoListResponseModel.fromJson(results))
            .toList();
      }
    } catch (e) {
      throw Exception('Error');
    }
    throw Exception('Error');
  }

  static Future<List<CouriersListResponseModel>> getCouriersList(id) async {
    final prefs = await SharedPreferences.getInstance();
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    try {
      final response = await dio
          .get(Urls.COURIERS_LIST_URL, queryParameters: {"cargo_id": id});
      if (response.statusCode == HttpStatus.ok) {
        List jsonResponse = response.data;
        return jsonResponse
            .map((e) => CouriersListResponseModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      throw Exception('Error');
    }
    throw Exception('Error');
  }

  static Future<List<GetDeliveriesResponseModel>> getDelivers(
      selectedDate) async {
    final prefs = await SharedPreferences.getInstance();
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    try {
      final response = await dio.get(
        Urls.LIST_URL,
        queryParameters: {"date": selectedDate},
      );
      if (response.statusCode == HttpStatus.ok) {
        await prefs.setInt('total_package', response.data['total_package']);
        List jsonResponse = response.data["results"];
        return jsonResponse
            .map((e) => GetDeliveriesResponseModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      throw Exception('Error');
    }
    throw Exception('Error');
  }

  static getTotalPackageCount(selectedDate) async {
    final prefs = await SharedPreferences.getInstance();
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    try {
      final response = await dio.get(
        Urls.LIST_URL,
        queryParameters: {"date": selectedDate},
      );
      if (response.statusCode == HttpStatus.ok) {
        return response.data['total_package'];
      }
    } catch (e) {
      throw Exception('Error');
    }
    throw Exception('Error');
  }

  // static deliveriesDelete(id) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
  //   dio.options.headers['Authorization'] =
  //       'Bearer ${prefs.getString('Authorization')}';
  //   dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
  //   try {
  //     final response =
  //         await dio.delete(Urls.DELETE_DELIVERIES_URL + id.toString() + '/');
  //     if (response.statusCode == HttpStatus.noContent) {
  //       return true;
  //     }
  //   } catch (e) {
  //     return e;
  //   }
  // }

  static postDelivery(String companyId, String courrierId, String packageCount,
      List<String> imagePathList) async {
    final prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://safex.web.tr/api/core/delivery/'));
    request.fields.addAll({
      'cargo_company': companyId,
      'courier': courrierId,
      'package_count': packageCount
    });
    var headers = {
      'Authorization': 'Bearer ${prefs.getString('Authorization')}'
    };
    for (int i = 0; i < imagePathList.length; i++) {
      request.files.add(
          await http.MultipartFile.fromPath('new_images', imagePathList[i]));
    }
    request.headers.addAll(headers);
    var response = await request.send();
    if (response.statusCode == HttpStatus.created) {
      var jsonResponse = json.decode(await response.stream.bytesToString());
      return jsonResponse['id'];
    } else {
      return false;
    }
  }

  static getDeliveryDetail(id) async {
    final prefs = await SharedPreferences.getInstance();
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    try {
      final response = await dio.get(Urls.GET_DELIVERY_DETAIL + id.toString());
      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      }
    } catch (e) {
      return e;
    }
  }

  static getDeliveryImages(id) async {
    final prefs = await SharedPreferences.getInstance();
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    try {
      final response = await dio.get(Urls.GET_DELIVERY_DETAIL + id.toString());
      if (response.statusCode == HttpStatus.ok) {
        return response.data['images'];
      }
    } catch (e) {
      return e;
    }
  }

  // static Future<List<PackageResponseModel>> getPackageList() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
  //   dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
  //   dio.options.headers['Authorization'] =
  //       'Bearer ${prefs.getString('Authorization')}';
  //   try {
  //     final response = await dio.get(Urls.PACKAGE_LIST);
  //     if (response.statusCode == HttpStatus.ok) {
  //       List jsonResponse = response.data["results"];
  //       return jsonResponse
  //           .map((e) => PackageResponseModel.fromJson(e))
  //           .toList();
  //     }
  //   } catch (e) {
  //     throw Exception('Error');
  //   }
  //   throw Exception('Error');
  // }
  static Future<List<PackageModel>> getPackageList(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    try {
      final response = await dio
          .get(Urls.PACKAGE_LIST, queryParameters: {"delivery_id": id});
      if (response.statusCode == HttpStatus.ok) {
        List jsonResponse = response.data;
        return jsonResponse.map((e) => PackageModel.fromJson(e)).toList();
      }
    } catch (e) {
      throw Exception('Error');
    }
    throw Exception('Error');
  }

  static updatePackageList(
      int delivery, int packageId, List<String> imagePathList) async {
    final prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest(
        'PUT', Uri.parse('https://safex.web.tr/api/core/package/$packageId/'));
    request.fields.addAll({
      'delivery': delivery.toString(),
    });
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${prefs.getString('Authorization')}'
    };
    for (int i = 0; i < imagePathList.length; i++) {
      request.files.add(
          await http.MultipartFile.fromPath('new_images', imagePathList[i]));
    }
    request.headers.addAll(headers);
    var response = await request.send();
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }

  static deletePackage(
      int delivery, int packageId, List<String> imagePathList) async {
    final prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest(
        'PUT', Uri.parse('https://safex.web.tr/api/core/package/$packageId/'));
    request.fields.addAll({
      'delivery': delivery.toString(),
    });
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${prefs.getString('Authorization')}'
    };

    request.headers.addAll(headers);
    var response = await request.send();
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }

  static getPackageDetails(id) async {
    final prefs = await SharedPreferences.getInstance();
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    try {
      final response = await dio.get(Urls.GET_PACKAGE_DETAIL + id.toString());
      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      }
    } catch (e) {
      return e;
    }
  }
}
