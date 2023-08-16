import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:locations_app/utils/icons.dart';
import '../utils/utility_functions.dart';

class MarkerProvider with ChangeNotifier{
  Set<Marker> markers = {};
  bool isGoing = false;
  bool dotter = false;
   Timer? timer;
  int seconds=0;
  String realTime = "";

  void formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    realTime = "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
    notifyListeners();
  }
  increaseSeconds(){
    timer =  Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds++;
      formatTime(seconds);
      notifyListeners();
    });
  }

  void whenCancelPressed(){
    seconds=0;
    isGoing=false;
  }


  getStart(LatLng latLng) async {
    Uint8List uint8list = await getBytesFromAsset(AppIcons.start, 100);
    markers.add(Marker(
        markerId: MarkerId(
          DateTime.now().toString(),
        ),
        position: latLng,
        icon: BitmapDescriptor.fromBytes(uint8list),
        // icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
            title: "Start")));
    dotter=true;
    notifyListeners();
  }
  addDot(LocationData locationData) async {
    Uint8List uint8list = await getBytesFromAsset(AppIcons.dot, 20);
    double lat = locationData.latitude!;
    double lon = locationData.longitude!;
    markers.add(Marker(
        markerId: MarkerId(
          DateTime.now().toString(),
        ),
        position: LatLng(lat, lon),
        icon: BitmapDescriptor.fromBytes(uint8list),
        // icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
            title: "On going")));
    // notifyListeners();
  }
  finishIt(LatLng latLng) async {
    Uint8List uint8list = await getBytesFromAsset(AppIcons.finish, 100);
    markers.add(Marker(
        markerId: MarkerId(
          DateTime.now().toString(),
        ),
        position: latLng,
        icon: BitmapDescriptor.fromBytes(uint8list),
        // icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
            title: "FINISH")));
    dotter=true;
    notifyListeners();
  }
  turnOnDotter(){
    dotter=true;
    notifyListeners();
  }
  changeGoingState(){
    isGoing=true;
    notifyListeners();
  }

}