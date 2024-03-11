import 'package:flutter_screenutil/flutter_screenutil.dart';

const double designWidth = 428;
const double designHeight = 926;

double getHeight(double height) {
  return (height / designHeight).sh;
}

double getWeight(double width) {
  return (width / designWidth).sw;
}
