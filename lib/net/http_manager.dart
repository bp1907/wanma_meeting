import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:wanma_meeting/config/config.dart';
import 'package:wanma_meeting/net/code.dart';
import 'package:wanma_meeting/net/result_data.dart';

class HttpManager {

  static const CONTENT_TYPE_JSON = 'application/json';
  static const CONTENT_TYPE_FORM = 'application/x-www-form-urlencoded';

  static Map optionParams = {
    'timeoutMs': 10000,
    'token': null,
    'authorizationCode': null,
  };

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  static netFetch(url, params, Map<String,String> header, Options option, {noTip = false}) async{
    //判断网络
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult == ConnectivityResult.none) {
      return ResultData(Code.errorHandleFunction(Code.NETWORK_ERROR, '', noTip),
          false, Code.NETWORK_ERROR);
    }

    Map<String, String> headers = HashMap();
    if(header != null) {
      headers.addAll(header);
    }

    if(option != null) {
      option.headers = headers;
    }else {
      option = Options(method: 'get');
      option.headers = headers;
    }

    ///超时
    option.connectTimeout = optionParams['timeoutMs'];

    Dio dio = Dio();
    Response response;
    try{
      response = await dio.request(url,queryParameters: params,options: option);
    }on DioError catch(e) {
      Response errorResponse;
      if(e.response != null) {
        errorResponse = e.response;
      }else {
        errorResponse = Response(statusCode: 111);
      }
      if(e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      if(Config.DEBUG){
        print('请求异常：' + e.toString());
        print('请求异常url：' + url);
      }
      return ResultData(Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip),false,errorResponse.statusCode);
    }

    //调试模式
    if (Config.DEBUG) {
      print('请求url: ' + url);
      print('请求头: ' + option.headers.toString());
      if (params != null) {
        print('请求参数: ' + params.toString());
      }
      if (response != null) {
        print('返回参数: ' + response.toString());
      }
      if (optionParams["authorizationCode"] != null) {
        print('authorizationCode: ' + optionParams["authorizationCode"]);
      }
    }

    if(option.contentType != null && option.contentType.primaryType == 'text') {
      return ResultData(response.data, true, Code.SUCCESS);
    }else {
    }

    if(response.statusCode == 200) {
      return ResultData(response.data, true, Code.SUCCESS, headers: response.headers);
    }
    return ResultData(Code.errorHandleFunction(response.statusCode, '', noTip), false, response.statusCode);
  }

}