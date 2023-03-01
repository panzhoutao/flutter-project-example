import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_utils_code/flutter_utils_code.dart';
import '../../entitys/response_entity.dart';
import '../../generated/json/base/json_convert_content.dart';
import '../../utils/login_utils.dart';
import '../../utils/toast_utils.dart';
import 'api.dart';
import 'interceptor/req_res_interceptor.dart';

///
enum HttpMethod {
  GET,
  POST,
  DELETE,
  PUT,
  UPLOAD,
  DOWNLOAD,
}

///
///
///
class NetService {
  static const Duration CONNECT_TIMEOUT = Duration(seconds: 20);
  static const Duration RECEIVE_TIMEOUT = Duration(seconds: 20);

  factory NetService() => _getInstance();

  static NetService? _instance;

  static NetService get instance => _getInstance();

  NetService._internal() {
    init();
  }

  static NetService _getInstance() {
    _instance ??= NetService._internal();
    return _instance!;
  }

  ///
  final Dio _dio = Dio();

  ///
  void init() {
    _dio.options = BaseOptions(
      connectTimeout: CONNECT_TIMEOUT,
      receiveTimeout: RECEIVE_TIMEOUT,
      responseType: ResponseType.json,
      baseUrl: Api.baseUrl,
    );

    // _dio.interceptors.add(DioLogInterceptor());
    _dio.interceptors.add(OnReqResInterceptors());
  }

  ///set proxy
  void setProxy(String httpProxyIp) {
    HttpClientAdapter;
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) {
        return httpProxyIp.isEmptyOrNull()
            ? 'DIRECT'
            : 'PROXY $httpProxyIp:8888';
      };
    };
  }

  /// Example:
  ///    BasicNetService.instance!.get(
  ///       '/api/banners',
  ///     );
  /// or
  ///   await BasicNetService.instance!.request(
  ///      '/api/categories',
  ///       method: Method.GET,
  ///       onSuccess: (response , data){
  ///       },
  ///       onFail: (response , msg){
  ///       },
  ///     );
  Future request<R>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    HttpMethod method = HttpMethod.POST,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool printLog = true,
    bool showDialog = true,
  }) async {
    late Response response;
    if (showDialog) {
      Toast.showLoading();
    }

    try {
      response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options ?? Options(method: method.name),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      ResponseEntity baseModel = ResponseEntity.fromJson(response.data);
      if (!baseModel.msgCode.isEmptyOrNull()) {
        //E9010未注册
        if (baseModel.msgCode == 'E9010' || baseModel.msgCode == 'E9006') {
          return baseModel;
        } else if (baseModel.msgCode == 'E9000' ||
            baseModel.msgCode == 'E9004') {
          LoginUtils.loginOut();
          return;
        }
      }

      if (baseModel.code == 0) {
        if (baseModel.data == null) {
          return true;
        } else if (baseModel.data is String) {
          return baseModel.data;
        } else {
          return jsonConvert.convert<R>(baseModel.data) ?? baseModel.data;
        }
      } else {
        showToast(baseModel.msg!);
        return null;
      }
    } on DioError catch (e) {
      return null;
    } finally {
      if (showDialog) {
        Toast.closeAllLoading();
      }
    }
  }
}
