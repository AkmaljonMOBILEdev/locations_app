import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Space on num{
  SizedBox get bh=>SizedBox(height: toDouble().h,);
  SizedBox get bw=>SizedBox(width: toDouble().w,);
}