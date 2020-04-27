import 'package:flutter/material.dart';
import 'package:wanma_meeting/common/local/local_storage.dart';
import 'package:wanma_meeting/config/config.dart';
import 'package:wanma_meeting/dao/data_dao.dart';
import 'package:wanma_meeting/json/json_string.dart';
import 'dart:convert';
import 'dart:async';

import 'package:wanma_meeting/page/meeting_list.dart';
import 'package:wanma_meeting/page/meeting_setup.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHomePage extends StatelessWidget {

  static final  String sName = 'MyHomePage';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize:Size.fromHeight(100),
            child:SafeArea(
              top: true,
              child: Offstage(),
            ),
          ),
        body: Container(
          padding: EdgeInsets.only(left: 10, top: 10, right: 10),
          color: Colors.white30,
          child: HomePageBody(),
        ),
      ),
      onWillPop: () => _dialogExitApp(context),
    );
  }

  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('确定要退出应用？'),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('取消')
            ),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('确定')
            ),
          ],
        ));
  }
}


class HomePageBody extends StatefulWidget {

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}


class _HomePageBodyState extends State<HomePageBody> {

  var _id;

  var resultData;

  Future _getMeetingDatas() async {
    _id = await LocalStorage.get(Config.MEETING_ID);
    resultData = await DataDao.getAppMenu(_id);
//    resultData = await json.decode(JsonString.mockData2);
    if(!mounted) {
      return;
    }
    if(resultData == null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MeetingSetup(),
          )
      ).then((data) {
        _getMeetingDatas();
      });
      Fluttertoast.showToast(msg: '无效的会议室Id,请重新设置');
    }else {
      setState(() {

      });
    }
//    return data;
//    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getId();
    print('homepage initState');
  }


  _getId() async {
    _id = await LocalStorage.get(Config.MEETING_ID);
    if(_id == '') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MeetingSetup(),
          )
      ).then((data) {
        _getMeetingDatas();
        Timer.periodic(Duration(minutes: 5), (timer) {
          _getMeetingDatas();
        });
      }
      );
    }else {
      _getMeetingDatas();
      Timer.periodic(Duration(minutes: 5), (timer) {
          _getMeetingDatas();
      });

    }
  }

  _getTitleContainer(title) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 60,
        child: Center(child: Text(title, style: TextStyle(fontSize: 20, color: Colors.white),),),
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
          color: (flag%2==1) ? Colors.black12 : Colors.white,
          child: Center(
            child: Text(content),
          )
      ),
    );
  }

  List<TableRow> _tableList(dataList) {
    TableRow _tableRow;
    List<TableRow> _tableRowList = <TableRow>[
//      TableRow(
//          children: <Widget>[
//            _getTitleContainer('日期'),
//            _getTitleContainer('时间'),
//            _getTitleContainer('会议主题'),
//            _getTitleContainer('预约人'),
//          ]
//      )
    ];
    for(int i = 0;i < dataList.length;i++) {
      _tableRow = TableRow(
        children: <Widget>[
          _getContentContainer(i, dataList[i]['begindate']+' - '+ dataList[i]['enddate'], dataList),
          _getContentContainer(i, dataList[i]['begintime']+' - '+ dataList[i]['endtime'], dataList),
          _getContentContainer(i, dataList[i]['meeting_subject'], dataList),
          _getContentContainer(i, dataList[i]['meeting_container'], dataList),
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
    print('homepage build');
    if(resultData != null) {
      if(resultData['code'] == '0') {
        var dataResult = resultData['result'];
        var curMeeting = dataResult['curmeeting'];
        var meetings = dataResult['meetings'];
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              image: DecorationImage(
                image: AssetImage('images/login_background.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 200,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 200,
                              height: 120,
                              color: Colors.blue,
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  '${curMeeting['meeting_name']}',
                                  style: TextStyle(fontSize: 20, color: Colors.white),),
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 50,
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  '当前会议',
                                  style: TextStyle(fontSize: 20, color: Colors.lightBlue),),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _showMeetingMessage(context, curMeeting);
                                },
                                child: Container(
                                  width: 200,
                                  padding: EdgeInsets.all(20),
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        '${curMeeting['meeting_subject']}',
                                        style: TextStyle(fontSize: 18, color: Colors.lightBlue),
                                      ),
                                      Text(
                                        '${curMeeting['begintime']} --- ${curMeeting['endtime']}',
                                        style: TextStyle(fontSize: 18, color: Colors.lightBlue),
                                      ),
                                      Text(
                                        '${curMeeting['meeting_container']}',
                                        style: TextStyle(fontSize: 18, color: Colors.lightBlue),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 30,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  '点击该区域或列表项显示详细参会人',
                                  style: TextStyle(fontSize: 10, color: Colors.red),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 60,
                              padding: EdgeInsets.all(10),
                              color: Colors.blue,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Image.asset('images/launch_image.png', scale: 3,),
                                      Padding(padding: EdgeInsets.all(10)),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => MeetingSetup(),
                                              )
                                          ).then((data) {
                                            _getMeetingDatas();
                                          });
                                        },
                                        child: Text('万马集团', style: TextStyle(fontSize: 18,color: Colors.white,),),
                                      ),
                                    ],),
                                  Text('当天会议列表', style: TextStyle(fontSize: 18,color: Colors.white),),
                                  Text(''),
                                  Text(''),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.lightBlue,
                              child: Row(
                                children: <Widget>[
                                  _getTitleContainer('日期'),
                                  _getTitleContainer('时间'),
                                  _getTitleContainer('会议主题'),
                                  _getTitleContainer('预约人'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: ListView(
                                  children: <Widget>[
                                    Table(
                                      children: _tableList(meetings),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(10),),
                MyBottomSheet(),
              ],
            ),
          ),
        );
      }else {
        return Container();
      }
    }else {
      return Container();
    }

  }

//  @override
//  void deactivate() async{
//    super.deactivate();
//    print('homepage deactive');
//    _id = await LocalStorage.get(Config.MEETING_ID);
//    if(_id == '') {
//
//    }else {
//      _getMeetingDatas();
//      print(_id+'...');
//    }
//  }

  @override
  void dispose() {
    super.dispose();
    print('homepage dispose');
  }
}

class MyBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Image.asset('images/launch_image.png', scale: 3,),
                Padding(padding: EdgeInsets.all(10)),
                Text('正人、正事、正品', style: TextStyle(fontSize: 25),),
              ],
            ),
          ),
          ShowTime(),
        ],
      ),
    );
  }
}


class ShowTime extends StatefulWidget {
  @override
  _ShowTimeState createState() => _ShowTimeState();
}

class _ShowTimeState extends State<ShowTime> {

  var currentTime = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if(!mounted) {
        return;
      }
      setState(() {
        currentTime = DateTime.now().toString().substring(0, 19);
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
                  text: " 当前时间："),
              TextSpan(
                  text: currentTime,
                  style: TextStyle(
                    fontSize: 25.0,
                  ))
            ]),
          )
        ],
      ),
    );
  }
}
