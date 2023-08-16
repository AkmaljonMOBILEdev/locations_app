import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locations_app/providers/marker_provider.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
        onTap: () {
          context.read<MarkerProvider>().turnOnDotter();
          context.read<MarkerProvider>().changeGoingState();
          context.read<MarkerProvider>().increaseSeconds();
        },
        child: Container(
          width: 34.w,
          height: 34.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              color: Colors.deepPurple),
          child: const Icon(
            Icons.directions_rounded,
            color: Colors.white,
          ),
        ));
  }
}
