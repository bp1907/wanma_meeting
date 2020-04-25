import 'package:flutter/material.dart';
import 'package:wanma_meeting/page/meeting_setup.dart';

class MeetingList extends StatelessWidget {

  final List dataList;
  MeetingList(this.dataList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会议信息'),
      ),
      body: MeetingListBody(dataList),
    );
  }
}

class MeetingListBody extends StatefulWidget {

  final List dataList;
  MeetingListBody(this.dataList);

  @override
  _MeetingListBodyState createState() => _MeetingListBodyState();
}

class _MeetingListBodyState extends State<MeetingListBody> {

  _getTitleContainer(title) {
    return Container(
      height: 50,
      color: Colors.lightBlue,
      child: Center(child: Text(title, style: TextStyle(fontSize: 20, color: Colors.white),),),
    );
  }

  _getContentContainer(flag, content) {
    return Container(
        height: 50,
        color: (flag%2==1) ? Colors.black12 : Colors.white,
        child: Center(
          child: Text(content),
        )
    );
  }

  List<TableRow> _tableList() {
    TableRow _tableRow;
    List<TableRow> _tableRowList = <TableRow>[
      TableRow(
          children: <Widget>[
            _getTitleContainer('主题'),
            _getTitleContainer('日期'),
            _getTitleContainer('时间'),
            Container(
                height: 50,
                color: Colors.lightBlue,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          child: Text(
                            '预订人',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )
                      ),
                      IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MeetingSetup(),
                              )
                          );
                        },
                      )
                    ],
                  ),
                )),
          ]
      )
    ];
    for(int i = 0;i < widget.dataList.length;i++) {
      _tableRow = TableRow(
        children: <Widget>[
          _getContentContainer(i, widget.dataList[i]['meeting_subject']),
          _getContentContainer(i, widget.dataList[i]['begindate']+' - '+ widget.dataList[i]['enddate']),
          _getContentContainer(i, widget.dataList[i]['begintime']+' - '+ widget.dataList[i]['endtime']),
          _getContentContainer(i, widget.dataList[i]['meeting_container']),
        ]
      );
      _tableRowList.add(_tableRow);
    }
    return _tableRowList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Table(
            border: TableBorder.all(width: 1.0),
            children: _tableList(),
          )
        ],
      ),
    );
  }
}

