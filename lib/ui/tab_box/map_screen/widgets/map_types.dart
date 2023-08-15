import 'package:flutter/material.dart';
import 'package:locations_app/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../../providers/call_adress_provider.dart';

class MapTypes extends StatefulWidget {
  const MapTypes({super.key});

  @override
  State<MapTypes> createState() => _MapTypesState();
}

class _MapTypesState extends State<MapTypes> {
  String dropdownValue = mapTypes.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });

        context.read<CallAddressProvider>().updateType(dropdownValue);
      },
      items: mapTypes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.deepPurple,
              ),
              child: Text(value)),
        );
      }).toList(),
    );
  }
}