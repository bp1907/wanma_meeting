import 'dart:async';
import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanma_meeting/dao/data_dao.dart';
import 'package:wanma_meeting/common/utils/screen_utils.dart';
import 'dart:math' as math;

import 'package:wanma_meeting/json/json_string.dart';

class MyHomePage extends StatelessWidget {

  static final  String sName = 'MyHomePage';

  var lastClickTimeNum = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child:Transform.scale(scale: 1 / ScreenUtils.getDeviceRate(), child: Transform.rotate(angle: math.pi/2*3, child: Scaffold(
        appBar: PreferredSize(
          preferredSize:Size.fromHeight(100),
          child:SafeArea(
            top: true,
            child: Offstage(),
          ),
        ),
        body:
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.png'),
                fit: BoxFit.fill,
              )
          ),
          padding: EdgeInsets.all(5),
          child: HomePageBody(),
        ),
      ),),),
      onWillPop: () => _dialogExitApp(context),
    );
  }

  Future<bool> _dialogExitApp(BuildContext context) {

    var currentClickTimeNum = DateTime.now().millisecondsSinceEpoch;
    if(currentClickTimeNum - lastClickTimeNum >= 2000) {
      lastClickTimeNum = currentClickTimeNum;
      Fluttertoast.showToast(msg: '连按两次返回键退出应用');
    }else {
      SystemNavigator.pop();
    }
  }
}


class HomePageBody extends StatefulWidget {

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}


class _HomePageBodyState extends State<HomePageBody> {

  var _sk;

  var resultData;

  var timeNowStr;

  var morningTimeNum;
  var nightTimeNum;

  Future _getMeetingDatas() async {
    _sk = 'K70qhzmnT6irQgGg';
    resultData = await DataDao.getAppMenu(_sk);
//    resultData = await json.decode(JsonString.mockData3);
    if(!mounted) {
      return;
    }
    if(resultData == null) {
      Fluttertoast.showToast(msg: '暂无会议信息');
    }else {
      setState(() {
      });
    }
  }

  @override
  void initState() {
    super.initState();
    timeNowStr = formatDate(DateTime.now(), [yyyy, '年', m, '月', d, '日']);

    var tempTime = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    morningTimeNum = DateTime.parse('$tempTime 08:00:00').millisecondsSinceEpoch;
    nightTimeNum = DateTime.parse('$tempTime 18:00:00').millisecondsSinceEpoch;

    _getData();
    print('homepage initState');
  }

  _getData() async {
    _getMeetingDatas();
    Timer.periodic(Duration(minutes: 10), (timer) {
      var currentTimeNum = DateTime.now().millisecondsSinceEpoch;
      if(currentTimeNum >= morningTimeNum && currentTimeNum <= nightTimeNum) {
        _getMeetingDatas();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    print('eeewidth: ${ScreenUtils.getDeviceW()}, height: ${ScreenUtils.getDeviceH()}');
    print('homepage build');
    if(resultData != null) {
      if(resultData['code'] == '0') {
        var dataResult = resultData['result'];
        var meetings = dataResult['meetings'];
        return getWidget(meetings, dataResult['meetingAdmin'], true);
      }else {
        return getWidget(null, '', false);
      }
    }else {
      return getWidget(null, '', false);
    }

  }

  _getTitleContainer(title, flex, isLast) {
    return Container(
//        decoration: BoxDecoration(
//          border: !isLast ? Border(top: BorderSide(width: ScreenUtils.getDeviceRate()),
//              left: BorderSide(width: ScreenUtils.getDeviceRate())) :
//          Border(top: BorderSide(width: ScreenUtils.getDeviceRate()),
//            left: BorderSide(width: ScreenUtils.getDeviceRate()),
//            right: BorderSide(width: ScreenUtils.getDeviceRate()),
//          ),
//        ),
      height: ScreenUtils.getItemH(),
      child: Center(child: Text(title, style: TextStyle(fontSize: 20 * ScreenUtils.getDeviceRate(), fontWeight: FontWeight.w600),),),
    );
  }

  _getContentContainer(flag, content, dataList) {
    return TableRowInkWell(
      onTap: () {
        if(dataList != null) {
          _showMeetingMessage(context, dataList[flag]);
        }
      },
      child:
      Container(
//          height: ScreenUtils.getItemH(),
//          color: (flag%2==1) ? Colors.black12 : Colors.white,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(content, style: TextStyle(fontSize: 15 * ScreenUtils.getDeviceRate()),),
            ),
          )
      ),
    );
  }

  List<TableRow> _tableList(dataList) {
    TableRow _tableRow;
    List<TableRow> _tableRowList = <TableRow>[
      TableRow(
        children: <Widget>[
          _getTitleContainer('会议项目', 4, false),
          _getTitleContainer('会议室', 3, false),
          _getTitleContainer('预定时间', 3, false),
          _getTitleContainer('联系人', 2, false),
          _getTitleContainer('人数', 2, true),
        ],
      )
    ];
    for(int i = 0;i < dataList.length;i++) {
      _tableRow = TableRow(
        children: <Widget>[
          _getContentContainer(i, dataList[i]['short_subject'], dataList),
          _getContentContainer(i, dataList[i]['short_mname'], dataList),
          _getContentContainer(i, dataList[i]['meeting_shorttime'], dataList),
          _getContentContainer(i, dataList[i]['meeting_container'], dataList),
          _getContentContainer(i, dataList[i]['chrs'], dataList),
        ],
      );
      _tableRowList.add(_tableRow);
    }
//    if(dataList.length < 13) {
//      var tempLength = 13 - dataList.length;
//      for(int i = 0; i<tempLength;i++) {
//        _tableRow = TableRow(
//          children: <Widget>[
//            _getContentContainer(i, '', null),
//            _getContentContainer(i, '', null),
//            _getContentContainer(i, '', null),
//            _getContentContainer(i, '', null),
//            _getContentContainer(i, '', null),
//          ],
//        );
//        _tableRowList.add(_tableRow);
//      }
//    }
    return _tableRowList;
  }

  //弹窗会议参与人
  _showMeetingMessage(context, curMeeting) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('会议信息', textAlign: TextAlign.center,),
            content: Container(
              width: 400,
              padding: EdgeInsets.all(10),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('会议主题：'),
                      Container(
                        width: 300,
                        child: Text(
                          '${curMeeting['meeting_subject']}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18, color: Colors.lightBlue),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Row(
                    children: <Widget>[
                      Text('会议时间：'),
                      Text(
                        '${curMeeting['begintime']} --- ${curMeeting['endtime']}',
                        style: TextStyle(fontSize: 18, color: Colors.lightBlue),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('参  会  人：'),
                            Expanded(
                              child: Text(
                                '${curMeeting['meeting_hrms']}',
                                style: TextStyle(fontSize: 18, color: Colors.lightBlue),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  getWidget(List meetings, String meetingAdmin, bool hasTableList) {
    return Center(
      child: Container(
        width: ScreenUtils.getDeviceH() * ScreenUtils.getDeviceRate(),
        height: ScreenUtils.getDeviceH(),
        padding: EdgeInsets.only(left: 2, right: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(15 * ScreenUtils.getDeviceRate()),),
            MyBottomSheet(timeNowStr),
            Expanded(
              child:Column(
                children: <Widget>[
//                  Container(
//                    height: ScreenUtils.getItemH(),
//                    child: Row(
//                      children: <Widget>[
//                        _getTitleContainer('会议项目', 4, false),
//                        _getTitleContainer('会议室', 3, false),
//                        _getTitleContainer('预定时间', 3, false),
//                        _getTitleContainer('联系人', 2, false),
//                        _getTitleContainer('人数', 2, true),
//                      ],
//                    ),
//                  ),
                  Expanded(
                    child: hasTableList ? Container(
//                          color: Colors.white,
                      child: ListView(
                        children: <Widget>[
                          Table(
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            border: TableBorder.all(width: ScreenUtils.getDeviceRate()),
                            columnWidths: {
                              0 : FlexColumnWidth(ScreenUtils.getDeviceH() * ScreenUtils.getDeviceRate() /7 *2),
                              1 : FlexColumnWidth(ScreenUtils.getDeviceH() * ScreenUtils.getDeviceRate() /14 *3),
                              2 : FlexColumnWidth(ScreenUtils.getDeviceH() * ScreenUtils.getDeviceRate() /14 *3),
                              3 : FlexColumnWidth(ScreenUtils.getDeviceH() * ScreenUtils.getDeviceRate() /7),
                              4 : FlexColumnWidth(ScreenUtils.getDeviceH() * ScreenUtils.getDeviceRate() /7),
                            },
                            children: _tableList(meetings),
                          )
                        ],
                      ),
                    ) : Container(),
                  ),
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: ScreenUtils.getDeviceH() * 0.3 - 1,
                  child: Image.asset('images/bottom.png', width: ScreenUtils.getDeviceH() * ScreenUtils.getDeviceRate(), fit: BoxFit.fill,),
                ),
                Positioned(
                  top: 10,
                    right: 10,
                    child: Text(meetingAdmin, style: TextStyle(fontSize: 18 * ScreenUtils.getDeviceRate()),),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print('homepage dispose');
  }
}

class MyBottomSheet extends StatelessWidget {

  final String timeStr;

  var width;
  var height;
  var rate;
  MyBottomSheet(this.timeStr);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80 * ScreenUtils.getDeviceRate(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2),
            child: Center(
              child: Text('万马创新园会议室预定情况', style: TextStyle(fontSize: 22 * ScreenUtils.getDeviceRate(), fontWeight: FontWeight.bold),),
            ),
          ),
          Container(
            padding: EdgeInsets.all(2),
            child: ShowTime(timeStr),
          ),
        ],
      ),
    );
  }
}


class ShowTime extends StatefulWidget {

  final String currentTime;
  ShowTime(this.currentTime);

  @override
  _ShowTimeState createState() => _ShowTimeState();
}

class _ShowTimeState extends State<ShowTime> {

//  var currentTime = '';

  @override
  void initState() {
    super.initState();
//    currentTime = widget.currentTime;
//    Timer.periodic(Duration(minutes: 1), (timer) {
//      if(!mounted) {
//        return;
//      }
//      setState(() {
//        currentTime = formatDate(DateTime.now(), [yyyy, '年', m, '月', d, '日']);
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    print('showtime build');
    return Container(
      width: ScreenUtils.getDeviceW(),
      padding: EdgeInsets.only(top: 5, right: 5),
      child: Text(
          widget.currentTime,
        textAlign: TextAlign.end,
        style: TextStyle(fontSize: 20 * ScreenUtils.getDeviceRate(), fontWeight: FontWeight.w400),
      ),
    );
  }
}
