import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class Services {
  // next three lines makes this class a Singleton

  static Services _instance = new Services.internal();
  Services.internal();
  factory Services() => _instance;

  static final _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Map> post(String url, {body, header}) async {
    return http
        .post(
          Uri.parse(url),

          body: json.encode(body),
          headers: header == null ? _headers : header,
        )
        .then((http.Response response) {
          final int statusCode = response.statusCode;
          dynamic responseDecoded = json.decode(response.body);
          print(statusCode.toString());
          print(responseDecoded);
          if (statusCode < 200 || statusCode > 400) {
            return {'response': '0', 'message': 'حدث خطأ فى تحميل البيانات'};
          } else {
            return responseDecoded;
          }
        });
  }

  Future<dynamic> postWithDio(
    String url, {
    body,
    Map<String, String>? headers,
  }) async {
    var responseJson;
    try {
      final response = await Dio().post(
        url,
        data: body,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
          headers: headers,
        ),
      );
      responseJson = _dioResponse(response);
    } catch (s) {
      print(s);
    }
    return responseJson;
  }

  Future<Map> get(String url, {Map<String, String>? header}) async {
    return http
        .get(Uri.parse(url), headers: header == null ? _headers : header)
        .then((http.Response response) {
          final int statusCode = response.statusCode;
          dynamic responseDecoded = json.decode(response.body);
          print(statusCode.toString());
          print(responseDecoded);
          if (statusCode < 200 || statusCode > 400) {
            return {'response': '0', 'message': 'حدث خطأ فى تحميل البيانات'};
          } else {
            return responseDecoded;
          }
        });
  }

  dynamic _dioResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        print(responseJson);
        return responseJson;

      case 401:
      case 500:
    }
  }
}
