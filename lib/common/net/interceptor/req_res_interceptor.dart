import 'package:dio/dio.dart';
import '../../../utils/log_util.dart';
import '../../../utils/sp_utils.dart';
import '../../../utils/toast_utils.dart';
import '../http_json_utils.dart';

///@Description:
///@Author:         @Mr.pan
///@CreateDate:     2021/12/23
class OnReqResInterceptors extends Interceptor {
  @override
  void onRequest (RequestOptions options, RequestInterceptorHandler handler) async{
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
    };

    if (SPUtils.instance.getToken() != null) {
      headers.addAll({
        'token': SPUtils.instance.getToken(),
      });
    }

    options.headers = headers;

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    HttpJsonUtil.printRespond(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    HttpJsonUtil.printRespond(err.response);
    Toast.showText(err.toString());
    Log.i(err.toString());
    super.onError(err, handler);
  }
}
