import 'package:flutter/material.dart';

class UbicacionSelector extends StatelessWidget {
  //final VoidCallback onPressed;

  const UbicacionSelector({
    Key? key,
    //required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.directions),
      ),
    );
  }
}
