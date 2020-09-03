import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtils {
  static double getDeviceH() {
    return ScreenUtil.screenHeight;
  }

  static double getDeviceW() {
    return ScreenUtil.screenWidth;
  }

  static getDeviceRate() {
    return getDeviceH()/getDeviceW();
  }

  static getItemH() {
    return (getDeviceH() * 0.7 - 80 * getDeviceRate() - 10) / 14;
  }
}