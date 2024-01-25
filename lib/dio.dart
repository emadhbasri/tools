import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'connectivity.dart';
import 'toast.dart';

enum ServiceKind { get, post, put, delete, postForm, rawGet, rawPost }

class Services {
  checkNet() async {}
  Services({this.server = ''});
  final String server;
  final Dio dio = Dio();
  bool getJson = true;
  bool doPrint = false;
  bool isDataJson = false;
  String? errorKey;
  ServiceKind kind = ServiceKind.postForm;
  Future<dynamic> makeRequest_(
      {required String url,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? headers,
      // bool noCheckNet = false,
      bool isDataJson = false, //todo
      required ServiceKind kind}) async {
    // if (!noCheckNet) {
    //   ConnectivityResult checkNet = await isOnline();
    //   debugPrint('checkNet ${checkNet}');
    //   if (checkNet == ConnectivityResult.none) {
    //     return const DataFailed('1 noNet');
    //   }
    // }
    dynamic data;
    print('parameters $parameters');
    // print('parametersparameters ${parameters.runtimeType}');
    // print('jsonEncode(parameters) ${jsonEncode(parameters).runtimeType}');
    if (isDataJson) {
      headers ??= {};
      headers['Content-Type'] = 'application/json';
      // print('parameters ${parameters}');
      data = jsonEncode(parameters);
      // print('dataJson ${data}');
    } else {
      data = parameters;
    }

    // if(kind==ServiceKind.postForm){
    //   headers ??= {};
    //   headers['Content-Type']='multipart/form-data';
    // }

    Options options = Options(
      headers: headers,
    );
    FutureOr<Response> fail =
        Response(requestOptions: RequestOptions(path: url), data: 'nonet1 catch', statusCode: 400);
    switch (kind) {
      case ServiceKind.get:
        return await dio
            .get(url, options: options, queryParameters: parameters)
            .catchError((e) async {
          debugPrint('catch error $e');
          return fail;
        });
      case ServiceKind.post:
        return await dio.post(url, options: options, data: data).catchError((e) async {
          debugPrint('catch error $e');
          return fail;
        });
      case ServiceKind.put:
        return await dio.put(url, options: options, data: data).catchError((e) async {
          debugPrint('catch error $e');
          return fail;
        });
      case ServiceKind.delete:
        return await dio.delete(url, options: options, data: data).catchError((e) async {
          debugPrint('catch error $e');
          return fail;
        });
      case ServiceKind.postForm:
        Map<String, dynamic> map = {};
        parameters?.forEach((key, value) async {
          if (value is Uint8List) {
            MultipartFile file = MultipartFile.fromBytes(value);
            map[key] = file;
          } else {
            map[key] = value;
          }
        });
        FormData data = FormData.fromMap(map);
        return await dio.post(url, options: options, data: data).catchError((e) async {
          debugPrint('catch error $e');
          return fail;
        });

      // default:
      //   return Response(
      //       requestOptions: RequestOptions(path: url),
      //       data: 'nonet',
      //       statusCode: 400);
      case ServiceKind.rawGet:
        return await dio
            .get(url, options: options, queryParameters: parameters)
            .catchError((e) async {
          debugPrint('catch error $e');
          return fail;
        });
      case ServiceKind.rawPost:
        return await dio.post(url, options: options, data: parameters).catchError((e) async {
          debugPrint('catch error $e');
          return fail;
        });
      default:
        return Response(
            requestOptions: RequestOptions(path: url), data: 'nonet2 default', statusCode: 400);
    }
  }

  // Future<DataState<dynamic>> httpPost()async{}
  // Future<DataState<dynamic>> httpPut()async{}
  // Future<DataState<dynamic>> httpDelete()async{}
  // Future<DataState<dynamic>> httpPostForm()async{}
  // Future<DataState<dynamic>> httpPostRaw()async{}

  Future<DataState> httpRequest(
      {ServiceKind? kind,
      String? url,
      String? errorKey,
      bool? isDataJson,
      // bool noCheckNet = true,
      bool? getJson,
      bool? doPrint,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? headers}) async {
    errorKey ??= this.errorKey;
    isDataJson ??= this.isDataJson;
    getJson ??= this.getJson;
    doPrint ??= this.doPrint;
    kind ??= this.kind;
    url = '$server$url';
    print('urlurl $url');

    if (doPrint) {
      debugPrint('start');
      debugPrint('url $url');
      debugPrint('parameters $parameters');
      debugPrint('headers $headers');
      debugPrint('kind $kind');
    }
    var response = await makeRequest_(
        isDataJson: isDataJson,
        // noCheckNet: noCheckNet,
        kind: kind,
        url: url,
        headers: headers,
        parameters: parameters);

    debugPrint('end');

    if (response is DataFailed) {
      return response;
    } else if (response is Response) {
      if (doPrint) {
        debugPrint('response.data ${response.data}');
      }
      if (response.statusCode == 400) {
        return DataFailed('2 ${response.data}');
      } else if (response.statusCode == 201 ||
          response.statusCode == 200 ||
          response.statusCode == 204) {
        if (kind == ServiceKind.rawGet || kind == ServiceKind.rawPost) {
          return DataSuccess(response.data);
        }

        try {
          dynamic json;
          if (getJson) {
            json = jsonDecode(response.data);
          } else {
            json = response.data;
          }
          return DataSuccess(json);
          // return DataSuccess(json);
        } catch (e) {
          return DataFailed('3 $e');
        }
      } else {
        try {
          var json = response.data; //jsonDecode();
          if (json is Map && json.containsKey(errorKey)) {
            return DataFailed('4 ${json[errorKey]}');
          } else {
            return const DataFailed('5');
          }
        } catch (e) {
          return DataFailed('6 $e');
        }
      }
    } else {
      return const DataFailed('7');
    }
  }
}

abstract class DataState<T> {
  final T? data;
  final String? error;
  const DataState(this.data, this.error);

  @override
  String toString() {
    return 'DataState{data: $data, error: $error}';
  }
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T? data) : super(data, null);

  @override
  String toString() {
    return 'DataSuccess{$data}';
  }
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(String error) : super(null, error);

  @override
  String toString() {
    return 'DataFailed{$error}';
  }
}

showSuccessCreate(BuildContext? context) {
  if (context != null) toast('داده‌ها ثبت شد', context);
}

showSuccessUpdate(BuildContext? context) {
  if (context != null) toast('داده‌ها بروزرسانی شد', context);

}

showError(BuildContext? context) {
  if (context != null) toast('مشکل در برقراری ارتباط با سرور', context,isLong: true);
}
