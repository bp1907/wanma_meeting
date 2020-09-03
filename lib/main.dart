import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanma_meeting/event/http_error_event.dart';
import 'dart:async';

import 'package:wanma_meeting/net/code.dart';
import 'package:wanma_meeting/page/home_page.dart';
import 'package:wanma_meeting/page/welcome_page.dart';

import 'config/config.dart';
import 'package:flutter/services.dart';

void main() {

//  runApp(MyApp());

  //处理未捕获异常
  FlutterError.onError = (FlutterErrorDetails details) async {
    //转发到当前zone
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  //自定义错误提示页面
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      body: Center(
        child: Text('Custom Error Widget', style: TextStyle(color: Colors.red),),
      ),
    );
  };

  runZoned<Future<Null>>(() async {
    WidgetsFlutterBinding.ensureInitialized();//初始化方法
    //强制横屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
//      DeviceOrientation.portraitUp,
//      DeviceOrientation.portraitDown
    ]).then((_) {
      runApp(MyApp());
    });
//    OrientationPlugin.forceOrientation(DeviceOrientation.portraitDown);
//    runApp(MyApp());
  }, onError: (error, stackTrace) async {
    //do sth for error
    print('error: $error,/n stack: $stackTrace');
    //TODO
    //推送错误信息
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wanma Meeting',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        WelcomePage.sName: (context) => WelcomePage(),
        MyHomePage.sName: (context) => CommonLayer(child: MyHomePage(),)
      },
//      home: CommonLayer(child: MyHomePage(),)
    );
  }
}


class CommonLayer extends StatefulWidget {
  final Widget child;

  CommonLayer({this.child});

  @override
  _CommonLayerState createState() => _CommonLayerState();
}

class _CommonLayerState extends State<CommonLayer> {

  StreamSubscription stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //stream控制eventbus的使用
    stream = Code.eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    if(stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        Fluttertoast.showToast(msg: '网络错误');
        break;
      case Code.NETWORK_TIMEOUT:
        Fluttertoast.showToast(msg: '请求超时');
        break;
//      case 200:
//        Fluttertoast.showToast(msg: message);
//        break;
      case 401:
        Fluttertoast.showToast(msg: '[401错误可能: 未授权 \\ 授权登录失败 \\ 登录过期]');
        break;
      case 403:
        Fluttertoast.showToast(msg: '403错误');
        break;
      case 404:
        Fluttertoast.showToast(msg: '404错误');
        break;
      default:
        Fluttertoast.showToast(msg: '其他异常 ' + message);
        break;
    }
  }
}
