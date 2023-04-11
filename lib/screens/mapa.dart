import 'package:flutter/material.dart';
import 'package:ponymapscross/components/ubicacionSelector.dart';

class Mapa extends StatelessWidget {
  const Mapa({Key? key}) : super(key: key);
  //bool showSelector = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Center(
          child: Text(
            'Mapa',
          ),
        ),
        Positioned(
          bottom: 10.0,
          right: 10.0,
          child: Padding(
            padding: EdgeInsets.only(bottom: 0, right: 0),
            child: UbicacionSelector(),
          ),
        ),
      ],
    );
  }
}

