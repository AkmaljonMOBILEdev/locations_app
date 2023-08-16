import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locations_app/providers/call_adress_provider.dart';
import 'package:locations_app/utils/constants.dart';
import 'package:locations_app/utils/sizebox.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class MapTypesRow extends StatefulWidget {
  const MapTypesRow({super.key});

  @override
  State<MapTypesRow> createState() => _MapTypesRowState();
}

class _MapTypesRowState extends State<MapTypesRow> {
  int selected = 0; // Initialize with 0 for the default selected index

  @override
  Widget build(BuildContext context) {
    String type = "Default";
    return SizedBox(
      height: 34.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: mapTypes.length,
        separatorBuilder: (context, index) {
          return 20.bw;
        },
        itemBuilder: (context, index) {
          return ZoomTapAnimation(
            onTap: () {
              setState(() {
                selected = index; // Update the selected index
              });

              if (mapTypes[index] == "Satellite") {
                type = mapTypes[index];
              } else if (mapTypes[index] == "Terrain") {
                type = mapTypes[index];
              }
              context.read<CallAddressProvider>().updateType(type);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: selected == index ? Colors.deepPurple : Colors.white,
                borderRadius: BorderRadius.circular(21.r),
                border: Border.all(
                  color: selected == index ? Colors.white : Colors.deepPurple,
                  width: 2.w,
                ),
              ),
              child: Center(
                child: Text(
                  mapTypes[index],
                  style: TextStyle(
                    color: selected == index ? Colors.white : Colors.deepPurple,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
