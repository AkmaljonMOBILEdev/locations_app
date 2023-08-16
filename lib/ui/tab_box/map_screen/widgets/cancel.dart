import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locations_app/providers/marker_provider.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: (){
        context.read<MarkerProvider>().whenCancelPressed();
      },
      child: Container(
        width: 34.w,
        height: 34.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21.r),
          color: Colors.white
        ),
        child: Icon(Icons.cancel, color: Colors.deepPurple,),

      ),
    );
  }
}
