import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locations_app/data/model/user_address.dart';
import 'package:locations_app/providers/call_adress_provider.dart';
import 'package:locations_app/providers/location_provider.dart';
import 'package:locations_app/providers/saved_list_provider.dart';
import 'package:locations_app/providers/tab_box_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<UserAddress> addresses =
        Provider.of<SavedListProvider>(context).addresses;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text("Saved Locations"),
      ),
      body: ListView(
        children: [
          if (addresses.isEmpty) Lottie.asset("assets/lottie/empty.json"),
          ...List.generate(addresses.length, (index) {
            UserAddress address = addresses[index];
            return ListTile(
                onTap: () {
                  context.read<CallAddressProvider>().getAddressByLatLong(
                      latLng: LatLng(address.lat, address.long));
                  context
                      .read<LocationProvider>()
                      .updateLatLong(LatLng(address.lat, address.long));
                  context.read<TabBoxProvider>().changeIndex(0);
                },
                onLongPress: () {
                  context
                      .read<SavedListProvider>()
                      .deleteUserAddress(address.id!);
                },
                title: RichText(
                    text: TextSpan(
                        text: "Location:  ",
                        style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.deepPurple),
                        children: [
                      TextSpan(
                        text: address.address,
                        style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.black)
                      )
                    ])),
                subtitle: Row(
                  children: [
                    RichText(text: TextSpan(
                      text: "Lat: ",
                      style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.deepPurple),
                      children: [
                        TextSpan(text: address.lat.toString().substring(0,5), style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.black))
                      ]
                    ),),
                    const Spacer(),
                    RichText(text: TextSpan(
                      text: "Long: ",
                      style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.deepPurple),
                      children: [
                        TextSpan(text: address.long.toString().substring(0,5), style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.black))
                      ]
                    ),),
                  ],
                ),
            );
          })
        ],
      ),
    );
  }
}
