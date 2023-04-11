import 'package:flutter/material.dart';
import 'package:ponymapscross/components/ubicacionSelector.dart';

class Mapa extends StatefulWidget {
  const Mapa({Key? key}) : super(key: key);

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  bool showSelector = false;
  double containerHeight = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Center(
          child: Text(
            'Mapa',
          ),
        ),
        Positioned(
          bottom: 10.0,
          right: 10.0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0, right: 0),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  showSelector = !showSelector;
                  containerHeight = showSelector ? 200.0 : 0.0;
                });
              },
              child: const Icon(Icons.directions),
            ),
          ),
        ),
        AnimatedPositioned(
          bottom: showSelector ? 10 : -200,
          right: 70,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOutBack,
          child: UbicacionSelector(),
        ),
      ],
    );
  }
}
