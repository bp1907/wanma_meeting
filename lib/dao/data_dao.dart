import 'package:dio/dio.dart';
import 'package:wanma_meeting/json/json_string.dart';
import 'dart:convert';

import 'package:wanma_meeting/net/http_manager.dart';
import 'package:wanma_meeting/net/url_constant.dart';

///获取数据
class DataDao {

  //获取会议数据
  static Future getAppMenu(mid) async{

    Map<String, dynamic> requestParams = {
      'mid': mid
    };

    var res = await HttpManager.netFetch(UrlConstant.getMeetingDatas(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      return res.data;
    }else {
      return null;
    }
  }
}