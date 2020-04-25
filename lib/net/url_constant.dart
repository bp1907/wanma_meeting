class UrlConstant {

  static const String host = 'http://172.18.0.94:9009/';

  ///获取会议数据
  static getMeetingDatas() {
    return '${host}services/getMeetings';
  }

}