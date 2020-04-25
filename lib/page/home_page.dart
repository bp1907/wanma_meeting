import 'package:flutter/material.dart';
import 'package:wanma_meeting/common/local/local_storage.dart';
import 'package:wanma_meeting/config/config.dart';
import 'package:wanma_meeting/json/json_string.dart';
import 'dart:convert';
import 'dart:async';

import 'package:wanma_meeting/page/meeting_list.dart';
import 'package:wanma_meeting/page/meeting_setup.dart';
import 'package:flutter/services.dart';

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
          color: Colors.white30,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  '正人、正事、正品',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'myfont',
                  ),
                ),
              ),
              HomePageBody(),
            ],
          ),
        ),
        bottomSheet: ShowTime(),
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

//class _HomePageBodyState extends State<HomePageBody> {
//
//  Future _futureStr;
//  var _id;
//
//  Future _getMeetingDatas() async {
////    String token = await HttpManager.getAuthorization();
////    String mid = '0';
////    var data = await DataDao.getAppMenu(token, mid, allTag, m);
//    return json.decode(JsonString.mockData);
//
////    return data;
////    }
//  }
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    _getId();
//    print('homepage initState');
//  }
//
//
//  _getId() async {
//    _id = await LocalStorage.get(Config.MEETING_ID);
//    if(_id == '') {
//      Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) => MeetingSetup(),
//          )
//      ).then((data) {
//        _futureStr = _getMeetingDatas();
//        print(data+'---');
//        setState(() {
//
//        });
//      }
//      );
//    }else {
//      _futureStr = _getMeetingDatas();
//      Timer.periodic(Duration(minutes: 5), (timer) {
//        setState(() {
//          _futureStr = _getMeetingDatas();
//        });
//      });
//
//    }
//  }
//
//  _myText(content, flag) {
//    return Text(
//      content,
//      style: TextStyle(fontSize: 20, color: flag ? Colors.blue : Colors.blueGrey),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
//    print('homepage build');
//    return FutureBuilder(
//          future: _futureStr,
//          builder: (context, snapshot) {
//            switch(snapshot.connectionState) {
//              case ConnectionState.waiting:
//                return Center(child: CircularProgressIndicator(semanticsLabel: '加载中...',),);
//              case ConnectionState.done:
//                if(snapshot.hasError) {
//                  return Text('${snapshot.error}',style: TextStyle(color: Colors.red),);
//                }else if(snapshot.hasData) {
//                  if(snapshot.data['code'] == '0') {
//                    var dataResult = snapshot.data['result'];
//                    return Center(
//                      child: Container(
//                        width: 600,
//                        height: 400,
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                          border: Border.all(width: 1),
//                          image: DecorationImage(
//                            image: AssetImage('images/login_background.jpg'),
//                            fit: BoxFit.fill,
//                          ),
//                        ),
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          children: <Widget>[
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceAround,
//                              children: <Widget>[
//                                _myText(dataResult['curmeeting']['meeting_name'], true),
//                                _myText(dataResult['curmeeting']['room_desc'], true),
//                              ],
//                            ),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: <Widget>[
//                                _myText(dataResult['curmeeting']['meeting_time'], false),
//                              ],
//                            ),
//                            Center(
//                              child: _myText(dataResult['curmeeting']['meeting_subject'], true),
//                            ),
//                            Center(child: _myText(dataResult['curmeeting']['meeting_eqp'], false),),
//                            Center(child: _myText(dataResult['curmeeting']['meeting_hrms'], true),),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceAround,
//                              children: <Widget>[
//                                RaisedButton(
//                                  onPressed: () {},
//                                  child: Text('当前会议'),
//                                  color: Colors.lightBlue,
//                                ),
//                                RaisedButton(
//                                  onPressed: () {
//                                    Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                          builder: (context) => MeetingList(dataResult['meetings']),
//                                        )
//                                    );
//                                  },
//                                  child: Text('会议信息一览'),
//                                  color: Colors.lightBlue,
//                                ),
//                              ],
//                            ),
//                          ],
//                        ),
//                      ),
//                    );
//                  }else {
//                    return Container();
//                  }
//                }else {
//                  return Container();
//                }
//                break;
//              default:
//                return Container();
//                break;
//            }
//          },
//        );
//  }
//
//  @override
//  void deactivate() async{
//    // TODO: implement deactivate
//    super.deactivate();
//    _id = await LocalStorage.get(Config.MEETING_ID);
//    if(_id == '') {
//
//    }else {
//      _futureStr = _getMeetingDatas();
//      if(!mounted) {
//        return;
//      }
//      setState(() {
//
//      });
//      print(_id+'...');
//    }
//    print('homepage deactive');
//  }
//
//  @override
//  void dispose() {
//    // TODO: implement dispose
//    super.dispose();
//    print('homepage dispose');
//  }
//}

class _HomePageBodyState extends State<HomePageBody> {

  Future _futureStr;
  var _id;

  var resultData;

  Future _getMeetingDatas() async {
//    String token = await HttpManager.getAuthorization();
//    String mid = '0';
//    var data = await DataDao.getAppMenu(token, mid, allTag, m);
    resultData = await json.decode(JsonString.mockData);
    setState(() {

    });
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
        print(data+'---');
      }
      );
    }else {
      _getMeetingDatas();
      Timer.periodic(Duration(minutes: 1), (timer) {
          _getMeetingDatas();
      });

    }
  }

  _myText(content, flag) {
    return Text(
      content,
      style: TextStyle(fontSize: 20, color: flag ? Colors.blue : Colors.blueGrey),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    print('homepage build');
    if(resultData != null) {
      if(resultData['code'] == '0') {
        var dataResult = resultData['result'];
        return Center(
          child: Container(
            width: 600,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              border: Border.all(width: 1),
              image: DecorationImage(
                image: AssetImage('images/login_background.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _myText(dataResult['curmeeting']['meeting_name'], true),
                    _myText(dataResult['curmeeting']['room_desc'], true),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _myText(dataResult['curmeeting']['meeting_time'], false),
                  ],
                ),
                Center(
                  child: _myText(dataResult['curmeeting']['meeting_subject'], true),
                ),
                Center(child: _myText(dataResult['curmeeting']['meeting_eqp'], false),),
                Center(child: _myText(dataResult['curmeeting']['meeting_hrms'], true),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {},
                      child: Text('当前会议'),
                      color: Colors.lightBlue,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MeetingList(dataResult['meetings']),
                            )
                        );
                      },
                      child: Text('会议信息一览'),
                      color: Colors.lightBlue,
                    ),
                  ],
                ),
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

  @override
  void deactivate() async{
    super.deactivate();
    print('homepage deactive');
    _id = await LocalStorage.get(Config.MEETING_ID);
    if(_id == '') {

    }else {
      _getMeetingDatas();
      print(_id+'...');
    }
  }

  @override
  void dispose() {
    super.dispose();
    print('homepage dispose');
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
