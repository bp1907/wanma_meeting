import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanma_meeting/dao/data_dao.dart';
import 'dart:math' as math;

class MyHomePage extends StatelessWidget {

  static final  String sName = 'MyHomePage';

  var lastClickTimeNum = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child:Scaffold(
        appBar: PreferredSize(
          preferredSize:Size.fromHeight(100),
          child:SafeArea(
            top: true,
            child: Offstage(),
          ),
        ),
        body:
//        Transform.rotate(angle: math.pi/2 * 3, child:
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.png'),
                fit: BoxFit.fill,
              )
          ),
          padding: EdgeInsets.all(5),
//          color: Colors.white30,
          child: HomePageBody(),
        ),
//        ),
      ),
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
//    return showDialog(
//        context: context,
//        builder: (context) => AlertDialog(
//          content: Text('确定要退出应用？'),
//          actions: <Widget>[
//            FlatButton(
//                onPressed: () => Navigator.of(context).pop(false),
//                child: Text('取消')
//            ),
//            FlatButton(
//                onPressed: () {
//                  Navigator.of(context).pop(true);
//                },
//                child: Text('确定')
//            ),
//          ],
//        ));
  }
}


class HomePageBody extends StatefulWidget {

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}


class _HomePageBodyState extends State<HomePageBody> {

  var _sk;

  var resultData;

  var timeToDayStr;
  var timeNowStr;

  var morningTimeNum;
  var nightTimeNum;

  var width;
  var height;

  Future _getMeetingDatas() async {
    _sk = 'K70qhzmnT6irQgGg';
    resultData = await DataDao.getAppMenu(_sk);
//    resultData = await json.decode(JsonString.mockData2);
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
    timeToDayStr = formatDate(DateTime.now(), [m, '月', d, '日']);
    timeNowStr = formatDate(DateTime.now(), [HH, ':', nn]);

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

  _getTitleContainer(title) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 2), left: BorderSide(), right: BorderSide(), bottom: BorderSide()),
        ),
        height: 60,
        child: Center(child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),),
      ),
    );
  }

  _getContentContainer(flag, content, dataList) {
    return TableRowInkWell(
      onTap: () {
        _showMeetingMessage(context, dataList[flag]);
      },
      child: Container(
          height: 60,
//          color: (flag%2==1) ? Colors.black12 : Colors.white,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(content),
            ),
          )
      ),
    );
  }

  List<TableRow> _tableList(dataList) {
    TableRow _tableRow;
    List<TableRow> _tableRowList = <TableRow>[];
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    print('width: $width, height: $height');
    print('homepage build');
    if(resultData != null) {
      if(resultData['code'] == '0') {
        var dataResult = resultData['result'];
        var meetings = dataResult['meetings'];
        return Center(
          child: Container(
//            width: height,
//            height: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
//              image: DecorationImage(
//                image: AssetImage('images/background.png'),
//                fit: BoxFit.fill,
//              ),
            ),
            child: Column(
              children: <Widget>[
                MyBottomSheet(timeToDayStr, timeNowStr),
                Expanded(
                  child:Column(
                    children: <Widget>[
                      Container(
//                        color: Colors.lightBlue,
                        child: Row(
                          children: <Widget>[
                            _getTitleContainer('会议项目'),
                            _getTitleContainer('会议室名称'),
                            _getTitleContainer('预定时间'),
                            _getTitleContainer('联系人'),
                            _getTitleContainer('人数'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
//                          color: Colors.white,
                          child: ListView(
                            children: <Widget>[
                              Table(
                                border: TableBorder.all(width: 1),
                                children: _tableList(meetings),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.25,
                  child: Image.asset('images/bottom.png', width: width, fit: BoxFit.fill,),
                ),
              ],
            ),
          ),
        );
      }else {
        return Center(
          child: Container(
//            width: height,
//            height: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              image: DecorationImage(
                image: AssetImage('images/background.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: <Widget>[
                MyBottomSheet(timeToDayStr, timeNowStr),
                Expanded(
                  child:Column(
                    children: <Widget>[
                      Container(
//                        color: Colors.lightBlue,
                        child: Row(
                          children: <Widget>[
                            _getTitleContainer('会议项目'),
                            _getTitleContainer('会议室名称'),
                            _getTitleContainer('预定时间'),
                            _getTitleContainer('联系人'),
                            _getTitleContainer('人数'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.25,
                  child: Image.asset('images/bottom.png', width: width, fit: BoxFit.fill,),
                ),
              ],
            ),
          ),
        );
      }
    }else {
      return Center(
        child: Container(
//          width: height,
//          height: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            image: DecorationImage(
              image: AssetImage('images/background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: <Widget>[
              MyBottomSheet(timeToDayStr, timeNowStr),
              Expanded(
                child:Column(
                  children: <Widget>[
                    Container(
//                        color: Colors.lightBlue,
                      child: Row(
                        children: <Widget>[
                          _getTitleContainer('会议项目'),
                          _getTitleContainer('会议室名称'),
                          _getTitleContainer('预定时间'),
                          _getTitleContainer('联系人'),
                          _getTitleContainer('人数'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 0.25,
                child: Image.asset('images/bottom.png', width: width, fit: BoxFit.fill,),
              ),
            ],
          ),
        ),
      );
    }

  }

  @override
  void dispose() {
    super.dispose();
    print('homepage dispose');
  }
}

class MyBottomSheet extends StatelessWidget {

  final String dayStr;
  final String timeStr;
  MyBottomSheet(this.dayStr,this.timeStr);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
//      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: 100,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text('$dayStr会议室使用情况', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            ),
          ),
          Container(
            width: 100,
            padding: EdgeInsets.all(10),
//            alignment: Alignment.bottomCenter,
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

  var currentTime = '';

  @override
  void initState() {
    super.initState();
    currentTime = widget.currentTime;
    Timer.periodic(Duration(minutes: 1), (timer) {
      if(!mounted) {
        return;
      }
      setState(() {
        currentTime = formatDate(DateTime.now(), [HH, ':', nn]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('showtime build');
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: currentTime,
                  style: TextStyle(
                    fontSize: 20.0,
                  ))
            ]),
          )
        ],
      ),
    );
  }
}
