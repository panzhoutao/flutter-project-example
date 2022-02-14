import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

class HttpJsonUtil {
  static JsonEncoder encoder = const JsonEncoder.withIndent('  ');

  static void printJson(Object object) {
    try {
      var encoderString = encoder.convert(object);
      // print(encoderString);
      debugPrint(encoderString);
      //prettyString.split('\n').forEach((element) => print(element));
    } catch (e) {
      print(e);
    }
  }

  static void printRespond(Response? response) {
    if(response == null){
      return;
    }
    Map httpLogMap = {};
    httpLogMap.putIfAbsent("requestUrl", () => "${response.requestOptions.uri}");
    httpLogMap.putIfAbsent("requestHeaders", () => response.requestOptions.headers);
    httpLogMap.putIfAbsent("requestethod", () => response.requestOptions.method);
    httpLogMap.putIfAbsent(
        "requestQueryParameters", () => response.requestOptions.queryParameters);
    // if(response.request is FormData){
    //   httpLogMap.putIfAbsent(
    //       "requestData", () => (response.request.data as FormData).toString());
    // }else {
    //   httpLogMap.putIfAbsent(
    //       "requestData", () => response.request.data);
    // }
    httpLogMap.putIfAbsent(
        "requestData", () => response.requestOptions.data.toString());
    httpLogMap.putIfAbsent("respondData", () => response.data);
    printJson(httpLogMap);
  }
}
