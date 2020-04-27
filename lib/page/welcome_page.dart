import 'package:flutter/material.dart';
import 'dart:async';

import 'package:wanma_meeting/page/home_page.dart';

class WelcomePage extends StatefulWidget {

  static final  String sName = '/';

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  bool hadInit = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(hadInit) return;
    hadInit = true;
    //防止多次进入
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(MyHomePage.sName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          color: Colors.white,
          child: Image.asset('images/launch_image.png',),
        );
  }
}
