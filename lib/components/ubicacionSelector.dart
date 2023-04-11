import 'package:flutter/material.dart';

class UbicacionSelector extends StatelessWidget {
  //final VoidCallback onPressed;

  const UbicacionSelector({
    Key? key,
    //required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
    );
  }
}
