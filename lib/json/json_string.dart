class JsonString {

  static final String mockData = '''
  {
  "code":"0",
  "errorCode":false,
  "msg":"success",
  "okCode":false,
  "result":{
       "curmeeting":{
           "begindate":"2020-04-18",
           "begintime":"08:30",
           "bookid":"7365",
           "enddate":"2020-04-18",
           "endtime":"17:00",
           "meeting_container":"陈秀英",
           "meeting_eqp":"一套音响系统,一套投影设备",
           "meeting_hrms":"陈秀英",
           "meeting_name":"电缆-二楼1号会议室（20人）",
           "meeting_subject":"项目会议",
           "meeting_time":"2020-04-18 08:30至2020-04-18 17:00",
           "room_desc":"可容纳20人"
       },
       "meetings":[
           {
               "begindate":"2020-04-18",
               "begintime":"08:30",
               "bookid":"7364",
               "enddate":"2020-04-18",
               "endtime":"17:00",
               "meeting_container":"陈秀英",
               "meeting_eqp":"一套音响系统,一套投影设备",
               "meeting_hrms":"陈秀英",
               "meeting_name":"电缆-二楼1号会议室（20人）",
               "meeting_subject":"项目会议",
               "meeting_time":"2020-04-18 08:30至2020-04-18 17:00",
               "room_desc":"可容纳20人"
           },
           {
               "begindate":"2020-04-18",
               "begintime":"08:30",
               "bookid":"7366",
               "enddate":"2020-04-18",
               "endtime":"17:00",
               "meeting_container":"陈秀英",
               "meeting_eqp":"一套音响系统,一套投影设备",
               "meeting_hrms":"陈秀英",
               "meeting_name":"电缆-二楼1号会议室（20人）",
               "meeting_subject":"项目会议",
               "meeting_time":"2020-04-18 08:30至2020-04-18 17:00",
               "room_desc":"可容纳20人"
           },
           {
               "begindate":"2020-04-18",
               "begintime":"08:30",
               "bookid":"7366",
               "enddate":"2020-04-18",
               "endtime":"17:00",
               "meeting_container":"陈秀英",
               "meeting_eqp":"一套音响系统,一套投影设备",
               "meeting_hrms":"陈秀英",
               "meeting_name":"电缆-二楼1号会议室（20人）",
               "meeting_subject":"项目会议",
               "meeting_time":"2020-04-18 08:30至2020-04-18 17:00",
               "room_desc":"可容纳20人"
           },
           {
               "begindate":"2020-04-18",
               "begintime":"08:30",
               "bookid":"7366",
               "enddate":"2020-04-18",
               "endtime":"17:00",
               "meeting_container":"陈秀英",
               "meeting_eqp":"一套音响系统,一套投影设备",
               "meeting_hrms":"陈秀英",
               "meeting_name":"电缆-二楼1号会议室（20人）",
               "meeting_subject":"项目会议",
               "meeting_time":"2020-04-18 08:30至2020-04-18 17:00",
               "room_desc":"可容纳20人"
           },
           {
               "begindate":"2020-04-18",
               "begintime":"08:30",
               "bookid":"7366",
               "enddate":"2020-04-18",
               "endtime":"17:00",
               "meeting_container":"陈秀英",
               "meeting_eqp":"一套音响系统,一套投影设备",
               "meeting_hrms":"陈秀英",
               "meeting_name":"电缆-二楼1号会议室（20人）",
               "meeting_subject":"项目会议",
               "meeting_time":"2020-04-18 08:30至2020-04-18 17:00",
               "room_desc":"可容纳20人"
           },
           {
               "begindate":"2020-04-18",
               "begintime":"08:30",
               "bookid":"7366",
               "enddate":"2020-04-18",
               "endtime":"17:00",
               "meeting_container":"陈秀英",
               "meeting_eqp":"一套音响系统,一套投影设备",
               "meeting_hrms":"陈秀英",
               "meeting_name":"电缆-二楼1号会议室（20人）",
               "meeting_subject":"项目会议",
               "meeting_time":"2020-04-18 08:30至2020-04-18 17:00",
               "room_desc":"可容纳20人"
           },
           {
               "begindate":"2020-04-18",
               "begintime":"08:30",
               "bookid":"7366",
               "enddate":"2020-04-18",
               "endtime":"17:00",
               "meeting_container":"陈秀英",
               "meeting_eqp":"一套音响系统,一套投影设备",
               "meeting_hrms":"陈秀英",
               "meeting_name":"电缆-二楼1号会议室（20人）",
               "meeting_subject":"项目会议",
               "meeting_time":"2020-04-18 08:30至2020-04-18 17:00",
               "room_desc":"可容纳20人"
           }
       ]
  },
  "warnCode":false
  }
''';

  static final String mockData2 = '''
{"code":"0","errorCode":false,"msg":"success","okCode":false,"result":{"curmeeting":{"begindate":"2020-04-24","begintime":"08:30","bookid":"7365","enddate":"2020-04-28","endtime":"17:00","meeting_container":"陈秀英","meeting_eqp":"一套音响系统,一套投影设备","meeting_hrms":"陈秀英,","meeting_name":"电缆-二楼1号会议室（20人）","meeting_subject":"项目会议","meeting_time":"2020-04-24 08:30至2020-04-28 17:00","room_desc":"可容纳20人"},"meetings":[{"begindate":"2020-04-24","begintime":"08:30","bookid":"7367","enddate":"2020-04-28","endtime":"17:00","meeting_container":"陈秀英","meeting_eqp":"一套音响系统,一套投影设备","meeting_hrms":"陈秀英,","meeting_name":"电缆-二楼1号会议室（20人）","meeting_subject":"项目会议","meeting_time":"2020-04-24 08:30至2020-04-28 17:00","room_desc":"可容纳20人"},{"begindate":"2020-04-24","begintime":"08:30","bookid":"7366","enddate":"2020-04-28","endtime":"17:00","meeting_container":"陈秀英","meeting_eqp":"一套音响系统,一套投影设备","meeting_hrms":"陈秀英,","meeting_name":"电缆-二楼1号会议室（20人）","meeting_subject":"项目会议","meeting_time":"2020-04-24 08:30至2020-04-28 17:00","room_desc":"可容纳20人"},{"begindate":"2020-04-24","begintime":"08:30","bookid":"7366","enddate":"2020-04-28888888888888888888888888888888888","endtime":"17:00","meeting_container":"陈秀英","meeting_eqp":"一套音响系统,一套投影设备","meeting_hrms":"陈秀英,","meeting_name":"电缆-二楼1号会议室（20人）","meeting_subject":"项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议","meeting_time":"2020-04-24 08:30至2020-04-28 17:00","room_desc":"可容纳20人"},{"begindate":"2020-04-24","begintime":"08:30","bookid":"7366","enddate":"2020-04-28","endtime":"17:00","meeting_container":"陈秀英","meeting_eqp":"一套音响系统,一套投影设备","meeting_hrms":"陈秀英,","meeting_name":"电缆-二楼1号会议室（20人）","meeting_subject":"项目会议","meeting_time":"2020-04-24 08:30至2020-04-28 17:00","room_desc":"可容纳20人"},{"begindate":"2020-04-24","begintime":"08:30","bookid":"7366","enddate":"2020-04-28","endtime":"17:00","meeting_container":"陈秀英","meeting_eqp":"一套音响系统,一套投影设备","meeting_hrms":"陈秀英,","meeting_name":"电缆-二楼1号会议室（20人）","meeting_subject":"项目会议","meeting_time":"2020-04-24 08:30至2020-04-28 17:00","room_desc":"可容纳20人"},{"begindate":"2020-04-24","begintime":"08:30","bookid":"7366","enddate":"2020-04-28","endtime":"17:00","meeting_container":"陈秀英","meeting_eqp":"一套音响系统,一套投影设备","meeting_hrms":"陈秀英,","meeting_name":"电缆-二楼1号会议室（20人）","meeting_subject":"项目会议","meeting_time":"2020-04-24 08:30至2020-04-28 17:00","room_desc":"可容纳20人"},{"begindate":"2020-04-24","begintime":"08:30","bookid":"7366","enddate":"2020-04-28","endtime":"17:00","meeting_container":"陈秀英","meeting_eqp":"一套音响系统,一套投影设备","meeting_hrms":"陈秀英,","meeting_name":"电缆-二楼1号会议室（20人）","meeting_subject":"项目会议","meeting_time":"2020-04-24 08:30至2020-04-28 17:00","room_desc":"可容纳20人"},{"begindate":"2020-04-24","begintime":"08:30","bookid":"7366","enddate":"2020-04-28","endtime":"17:00","meeting_container":"陈秀英","meeting_eqp":"一套音响系统,一套投影设备","meeting_hrms":"陈秀英,","meeting_name":"电缆-二楼1号会议室（20人）","meeting_subject":"项目会议","meeting_time":"2020-04-24 08:30至2020-04-28 17:00","room_desc":"可容纳20人"},{"begindate":"2020-04-24","begintime":"08:30","bookid":"7366","enddate":"2020-04-28","endtime":"17:00","meeting_container":"陈秀英","meeting_eqp":"一套音响系统,一套投影设备","meeting_hrms":"陈秀英,","meeting_name":"电缆-二楼1号会议室（20人）","meeting_subject":"项目会议","meeting_time":"2020-04-24 08:30至2020-04-28 17:00","room_desc":"可容纳20人"},{"begindate":"2020-04-24","begintime":"08:30","bookid":"7366","enddate":"2020-04-28","endtime":"17:00","meeting_container":"陈秀英","meeting_eqp":"一套音响系统,一套投影设备","meeting_hrms":"陈秀英,","meeting_name":"电缆-二楼1号会议室（20人）","meeting_subject":"项目会议","meeting_time":"2020-04-24 08:30至2020-04-28 17:00","room_desc":"可容纳20人"},{"begindate":"2020-04-24","begintime":"08:30","bookid":"7366","enddate":"2020-04-28","endtime":"17:00","meeting_container":"陈秀英","meeting_eqp":"一套音响系统,一套投影设备","meeting_hrms":"陈秀英,","meeting_name":"电缆-二楼1号会议室（20人）","meeting_subject":"项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议项目会议","meeting_time":"2020-04-24 08:30至2020-04-28 17:00","room_desc":"可容纳20人"}]},"warnCode":false}
  ''';

  static final String mockData3 = '''
{"code":"0","errorCode":false,"msg":"success","okCode":false,
"result":{"Status":"success","StatusMsg":"数据获取成功",
"meetingAdmin":"会议联系人：王振，15888812474",
"meetings":[
{"begindate":"2020-08-25","begintime":"09:00","bookid":"10592","chrs":"10","enddate":"2020-08-26","endtime":"17:00","meeting_container":"叶小挺","meeting_eqp":"","meeting_et":"17:00","meeting_hrms":"杨嘉禾,叶小挺,徐峻,余德平,刘焕新,朱青芳,方环,张钊,","meeting_name":"万马创新园6F-延安（12-14人）","meeting_shorttime":"00:00-17:00","meeting_st":"00:00","meeting_subject":"进口交联商务谈判","meeting_time":"2020-08-25 09:00至2020-08-26 17:00","room_desc":"12-14人","short_mname":"延安","short_subject":"进口交联商务谈判"},
{"begindate":"2020-08-26","begintime":"13:30","bookid":"10626","chrs":"","enddate":"2020-08-26","endtime":"15:30","meeting_container":"施少虹","meeting_eqp":"","meeting_et":"15:30","meeting_hrms":"姚国军,叶金龙,刘焕新,丁大雷,孙小红,熊承成,施少虹,","meeting_name":"万马创新园6F-遵义（14-18人）","meeting_shorttime":"13:30-15:30","meeting_st":"13:30","meeting_subject":"对标内部沟通会","meeting_time":"2020-08-26 13:30至2020-08-26 15:30","room_desc":"14-18人","short_mname":"遵义","short_subject":"对标内部沟通会"},
{"begindate":"2020-08-26","begintime":"14:00","bookid":"10630","chrs":"10","enddate":"2020-08-26","endtime":"16:00","meeting_container":"宋雪蕾","meeting_eqp":"","meeting_et":"16:00","meeting_hrms":"叶金龙,廖文华,杨娟,杨军1,刘焕新,孙磊,吕杭军,方环,宋雪蕾,靳长春,曹伟-基建,","meeting_name":"万马创新园6F-庐山（6-8人）","meeting_shorttime":"14:00-16:00","meeting_st":"14:00","meeting_subject":"低压车间施工图审查会","meeting_time":"2020-08-26 14:00至2020-08-26 16:00","room_desc":"6-8人","short_mname":"庐山","short_subject":"低压车间施工图审查会阿什顿奈良鹿B类罚款加上吧精神病vSBCAB"},
{"begindate":"","begintime":"","bookid":"","chrs":"","enddate":"","endtime":"","meeting_container":"","meeting_eqp":"","meeting_et":"-","meeting_hrms":"","meeting_name":"万马创新园6F-会宁（14-18人）","meeting_shorttime":"-","meeting_st":"-","meeting_subject":"","meeting_time":"","room_desc":"14-18人","short_mname":"会宁","short_subject":"闲置"},
{"begindate":"","begintime":"","bookid":"","chrs":"","enddate":"","endtime":"","meeting_container":"","meeting_eqp":"","meeting_et":"-","meeting_hrms":"","meeting_name":"万马创新园6F-古田（14-18人）","meeting_shorttime":"-","meeting_st":"-","meeting_subject":"","meeting_time":"","room_desc":"14-18人","short_mname":"古田","short_subject":"闲置"},
{"begindate":"","begintime":"","bookid":"","chrs":"","enddate":"","endtime":"","meeting_container":"","meeting_eqp":"","meeting_et":"-","meeting_hrms":"","meeting_name":"万马创新园6F-南湖（16-20人）","meeting_shorttime":"-","meeting_st":"-","meeting_subject":"","meeting_time":"","room_desc":"16-20人","short_mname":"南湖","short_subject":"闲置"},
{"begindate":"","begintime":"","bookid":"","chrs":"","enddate":"","endtime":"","meeting_container":"","meeting_eqp":"","meeting_et":"-","meeting_hrms":"","meeting_name":"万马创新园6F-党群活动室（30-60人）","meeting_shorttime":"-","meeting_st":"-","meeting_subject":"","meeting_time":"","room_desc":"30-60人","short_mname":"党群活动室","short_subject":"闲置"},
{"begindate":"","begintime":"","bookid":"","chrs":"","enddate":"","endtime":"","meeting_container":"","meeting_eqp":"","meeting_et":"-","meeting_hrms":"","meeting_name":"万马创新园6F-大培训教室（30-50人）","meeting_shorttime":"-","meeting_st":"-","meeting_subject":"","meeting_time":"","room_desc":"30-50人","short_mname":"大培训教室","short_subject":"闲置"},
{"begindate":"2020-08-26","begintime":"14:00","bookid":"10630","chrs":"10","enddate":"2020-08-26","endtime":"16:00","meeting_container":"宋雪蕾","meeting_eqp":"","meeting_et":"16:00","meeting_hrms":"叶金龙,廖文华,杨娟,杨军1,刘焕新,孙磊,吕杭军,方环,宋雪蕾,靳长春,曹伟-基建,","meeting_name":"万马创新园6F-庐山（6-8人）","meeting_shorttime":"14:00-16:00","meeting_st":"14:00","meeting_subject":"低压车间施工图审查会","meeting_time":"2020-08-26 14:00至2020-08-26 16:00","room_desc":"6-8人","short_mname":"庐山","short_subject":"低压车间施工图审查会"},
{"begindate":"2020-08-26","begintime":"14:00","bookid":"10630","chrs":"10","enddate":"2020-08-26","endtime":"16:00","meeting_container":"宋雪蕾","meeting_eqp":"","meeting_et":"16:00","meeting_hrms":"叶金龙,廖文华,杨娟,杨军1,刘焕新,孙磊,吕杭军,方环,宋雪蕾,靳长春,曹伟-基建,","meeting_name":"万马创新园6F-庐山（6-8人）","meeting_shorttime":"14:00-16:00","meeting_st":"14:00","meeting_subject":"低压车间施工图审查会","meeting_time":"2020-08-26 14:00至2020-08-26 16:00","room_desc":"6-8人","short_mname":"庐山","short_subject":"低压车间施工图审查会"},
{"begindate":"2020-08-26","begintime":"14:00","bookid":"10630","chrs":"10","enddate":"2020-08-26","endtime":"16:00","meeting_container":"宋雪蕾","meeting_eqp":"","meeting_et":"16:00","meeting_hrms":"叶金龙,廖文华,杨娟,杨军1,刘焕新,孙磊,吕杭军,方环,宋雪蕾,靳长春,曹伟-基建,","meeting_name":"万马创新园6F-庐山（6-8人）","meeting_shorttime":"14:00-16:00","meeting_st":"14:00","meeting_subject":"低压车间施工图审查会","meeting_time":"2020-08-26 14:00至2020-08-26 16:00","room_desc":"6-8人","short_mname":"庐山","short_subject":"低压车间施工图审查会"},
{"begindate":"2020-08-26","begintime":"14:00","bookid":"10630","chrs":"10","enddate":"2020-08-26","endtime":"16:00","meeting_container":"宋雪蕾","meeting_eqp":"","meeting_et":"16:00","meeting_hrms":"叶金龙,廖文华,杨娟,杨军1,刘焕新,孙磊,吕杭军,方环,宋雪蕾,靳长春,曹伟-基建,","meeting_name":"万马创新园6F-庐山（6-8人）","meeting_shorttime":"14:00-16:00","meeting_st":"14:00","meeting_subject":"低压车间施工图审查会","meeting_time":"2020-08-26 14:00至2020-08-26 16:00","room_desc":"6-8人","short_mname":"庐山","short_subject":"低压车间施工图审查会"},
{"begindate":"2020-08-26","begintime":"14:00","bookid":"10630","chrs":"10","enddate":"2020-08-26","endtime":"16:00","meeting_container":"宋雪蕾","meeting_eqp":"","meeting_et":"16:00","meeting_hrms":"叶金龙,廖文华,杨娟,杨军1,刘焕新,孙磊,吕杭军,方环,宋雪蕾,靳长春,曹伟-基建,","meeting_name":"万马创新园6F-庐山（6-8人）","meeting_shorttime":"14:00-16:00","meeting_st":"14:00","meeting_subject":"低压车间施工图审查会","meeting_time":"2020-08-26 14:00至2020-08-26 16:00","room_desc":"6-8人","short_mname":"庐山","short_subject":"低压车间施工图审查会"},
{"begindate":"2020-08-26","begintime":"14:00","bookid":"10630","chrs":"10","enddate":"2020-08-26","endtime":"16:00","meeting_container":"宋雪蕾","meeting_eqp":"","meeting_et":"16:00","meeting_hrms":"叶金龙,廖文华,杨娟,杨军1,刘焕新,孙磊,吕杭军,方环,宋雪蕾,靳长春,曹伟-基建,","meeting_name":"万马创新园6F-庐山（6-8人）","meeting_shorttime":"14:00-16:00","meeting_st":"14:00","meeting_subject":"低压车间施工图审查会","meeting_time":"2020-08-26 14:00至2020-08-26 16:00","room_desc":"6-8人","short_mname":"庐山","short_subject":"低压车间施工图审查会"},
{"begindate":"2020-08-26","begintime":"14:00","bookid":"10630","chrs":"10","enddate":"2020-08-26","endtime":"16:00","meeting_container":"宋雪蕾","meeting_eqp":"","meeting_et":"16:00","meeting_hrms":"叶金龙,廖文华,杨娟,杨军1,刘焕新,孙磊,吕杭军,方环,宋雪蕾,靳长春,曹伟-基建,","meeting_name":"万马创新园6F-庐山（6-8人）","meeting_shorttime":"14:00-16:00","meeting_st":"14:00","meeting_subject":"低压车间施工图审查会","meeting_time":"2020-08-26 14:00至2020-08-26 16:00","room_desc":"6-8人","short_mname":"庐山","short_subject":"低压车间施工图审查会"}]},
"warnCode":false}
  ''';
}