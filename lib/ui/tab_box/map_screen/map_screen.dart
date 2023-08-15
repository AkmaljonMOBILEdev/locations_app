import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locations_app/providers/call_adress_provider.dart';
import 'package:locations_app/providers/saved_list_provider.dart';
import 'package:locations_app/providers/tab_box_provider.dart';
import 'package:locations_app/ui/tab_box/map_screen/widgets/address_kind_selector.dart';
import 'package:locations_app/ui/tab_box/map_screen/widgets/address_lang_selector.dart';
import 'package:locations_app/ui/tab_box/map_screen/widgets/map_types.dart';
import 'package:locations_app/ui/tab_box/map_screen/widgets/save_button.dart';
import 'package:provider/provider.dart';
import '../../../data/model/user_address.dart';
import '../../../providers/location_provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late CameraPosition initialCameraPosition;
  late CameraPosition currentCameraPosition;
  bool onCameraMoveStarted = false;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    initialCameraPosition = CameraPosition(
      target: locationProvider.latLong!,
      zoom: 13,
    );

    currentCameraPosition = CameraPosition(
      target: locationProvider.latLong!,
      zoom: 13,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              onCameraMove: (CameraPosition cameraPosition) {
                currentCameraPosition = cameraPosition;
              },
              onCameraIdle: () {
                debugPrint(
                    "CURRENT CAMERA POSITION: ${currentCameraPosition.target.latitude}");

                context
                    .read<CallAddressProvider>()
                    .getAddressByLatLong(latLng: currentCameraPosition.target);

                setState(() {
                  onCameraMoveStarted = false;
                });

                debugPrint("MOVE FINISHED");
              },
              liteModeEnabled: false,
              myLocationEnabled: false,
              padding: const EdgeInsets.all(12),
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              mapType: context.watch<CallAddressProvider>().type,
              onCameraMoveStarted: () {
                setState(() {
                  onCameraMoveStarted = true;
                });
                debugPrint("MOVE STARTED");
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: initialCameraPosition,
            ),
            const Positioned(
                top: 2,
                right: 2,
                child: MapTypes()),
            Align(
                child: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: onCameraMoveStarted ? 45 : 35,
            )),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                child: Text(
                  context.watch<CallAddressProvider>().scrolledAddressText,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style:  TextStyle(
                    fontSize: 22,
                    color: context.watch<CallAddressProvider>().type==MapType.satellite?Colors.white:Colors.deepPurple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: AddressKindSelector(),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: AddressLangSelector(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                visible: context.watch<CallAddressProvider>().canSaveAddress(),
                child: SaveButton(onTap: () {
                  CallAddressProvider adp =
                      Provider.of<CallAddressProvider>(context, listen: false);
                  context.read<SavedListProvider>().insertUserAddress(
                        UserAddress(
                          lat: currentCameraPosition.target.latitude,
                          long: currentCameraPosition.target.longitude,
                          address: adp.scrolledAddressText,
                          created: DateTime.now().toString(),
                        ),
                      );
                  context.read<TabBoxProvider>().changeIndex(1);
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _followMe(cameraPosition: initialCameraPosition);
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.gps_fixed,
          color: Colors.white,
        ),
      ),
    );
  }
  Future<void> _followMe({required CameraPosition cameraPosition}) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

}
