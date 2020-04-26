class UrlConstant {

  static const String host = 'http://172.18.0.94:9009/';//测试
//  static const String host = 'http://oa.wanmagroup.com/';//正式

  ///获取会议数据
  static getMeetingDatas() {
    return '${host}wm/meeting/getMeetings.jsp';
  }

}