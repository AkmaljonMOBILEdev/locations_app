import 'package:flutter/material.dart';
import 'package:locations_app/providers/call_adress_provider.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart';

class AddressKindSelector extends StatefulWidget {
  const AddressKindSelector({Key? key}) : super(key: key);



  @override
  State<AddressKindSelector> createState() => _AddressKindSelectorState();
}

class _AddressKindSelectorState extends State<AddressKindSelector> {
  String dropdownValue = kindList.first;

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

        context.read<CallAddressProvider>().updateKind(dropdownValue);
      },
      items: kindList.map<DropdownMenuItem<String>>((String value) {
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