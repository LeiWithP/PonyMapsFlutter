import 'package:flutter/material.dart';

class Horarios extends StatefulWidget {
  final List<String> itemList;

  const Horarios({required this.itemList});

  @override
  _OriginDestinationPickerState createState() =>
      _OriginDestinationPickerState();
}

class _OriginDestinationPickerState extends State<Horarios> {
  String? _selectedOrigin;
  String? _selectedDestination;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButton<String>(
            value: _selectedOrigin,
            onChanged: (newValue) {
              setState(() {
                _selectedOrigin = newValue;
              });
            },
            items: widget.itemList
                .map((item) => DropdownMenuItem<String>(
              child: Text(item),
              value: item,
            ))
                .toList(),
            isExpanded: true,
            hint: Text('Select origin'),
          ),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: DropdownButton<String>(
            value: _selectedDestination,
            onChanged: (newValue) {
              setState(() {
                _selectedDestination = newValue;
              });
            },
            items: widget.itemList
                .map((item) => DropdownMenuItem<String>(
              child: Text(item),
              value: item,
            ))
                .toList(),
            isExpanded: true,
            hint: Text('Select destination'),
          ),
        ),
      ],
    );
  }
}
