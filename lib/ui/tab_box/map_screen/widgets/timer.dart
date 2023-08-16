import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locations_app/providers/marker_provider.dart';
import 'package:provider/provider.dart';

class MapTimer extends StatelessWidget {
  const MapTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      child: Text(context.watch<MarkerProvider>().realTime,style: TextStyle(
        color: Colors.deepPurple, fontWeight: FontWeight.w700, fontSize: 20.sp
      ),),

    );
  }
}
