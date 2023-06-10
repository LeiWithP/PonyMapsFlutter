import 'package:flutter/material.dart';
import 'package:ponymapscross/settings/testData.dart';

List<String> list = buildings.map((e) => e["building"]!).toList();

class DropdownUbication extends StatefulWidget {

   Function(String) updateData;

    DropdownUbication({
    super.key,
    required this.updateData
  });

  @override
  State<DropdownUbication> createState() => _DropdownUbicationState();
}

class _DropdownUbicationState extends State<DropdownUbication> {
  String dropdownValue = list.first;


  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      alignment: Alignment.center,
      menuMaxHeight: 120,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 0,
      style: TextStyle(
        fontSize: 25.0,
        color: Theme.of(context).colorScheme.secondary,
      ),
      underline: Container(
        height: 1,
        color: Theme.of(context).colorScheme.secondary,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
        widget.updateData(dropdownValue);
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
