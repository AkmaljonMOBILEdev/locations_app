import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
          height: 34.w,
          width: 34.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.deepPurple),
          child: const Center(
              child: Icon(Icons.save, color: Colors.white,))),
    );
    // return Material(
    //   //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    //   child: Ink(
    //     height: 50,
    //     width: 120,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(16),
    //       color: Colors.deepPurple,
    //     ),
    //     child: InkWell(
    //       borderRadius: BorderRadius.circular(20),
    //       onTap: onTap,
    //       child: const Center(
    //         child: Text(
    //           "SAVE",
    //           style: TextStyle(
    //             fontWeight: FontWeight.w500,
    //             color: Colors.white,
    //             fontSize: 20,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
