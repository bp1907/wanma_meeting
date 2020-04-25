import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanma_meeting/common/local/local_storage.dart';
import 'package:wanma_meeting/config/config.dart';

class MeetingSetup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MeetingSetupBody(),
    );
  }
}


class MeetingSetupBody extends StatefulWidget {
  @override
  _MeetingSetupBodyState createState() => _MeetingSetupBodyState();
}

class _MeetingSetupBodyState extends State<MeetingSetupBody> {
  String _id;
  final TextEditingController _idController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initParam();
  }

  initParam() async {
    _id = await LocalStorage.get(Config.MEETING_ID);

    _idController.value = TextEditingValue(text: _id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            body:SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.black12,
                  height:MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(left: 20,top: 20,right: 20,bottom: 100),
                  child: Column(
                    children: <Widget>[
                      _skSetting(context,_idController),
                      _sureBtn()
                    ],
                  ),
                ),
              ) ,
            )

        ),
        onWillPop: () {
          Navigator.of(context).pop();
          return Future.value();
        },
    );
  }


  Widget _skSetting (context, controller){
    return _commonTextFieldSet('会议室ID设置',controller);

  }

  Widget _commonTextFieldSet(content, TextEditingController editingController){

    return Container(
      padding: EdgeInsets.only(top: 20),
      child:   TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.settings),
          labelText: content,
          labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: 18
          ),

          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.pink
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        controller:editingController,
        focusNode: _focusNode,
        onChanged: (String values){
          _id = values;
        },


      ),

    );
  }


  Widget _sureBtn (){

    return InkWell(
      onTap: (){
        _focusNode.unfocus();
        if (_idController.text.length>0) {
          LocalStorage.save(Config.MEETING_ID, _id);
          print(_id+'===');
          Fluttertoast.showToast(msg: '会议室ID设置成功');
          Navigator.of(context).pop(_id);
        }
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(top: 35),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          //
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          '完成',
          style: TextStyle(color: Colors.white,fontSize: 18),
        ),
      ),
    );
  }

}