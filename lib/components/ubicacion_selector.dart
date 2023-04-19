import 'package:flutter/material.dart';
import 'package:ponymapscross/components/dropdownUbication.dart';

class UbicacionSelector extends StatelessWidget {
  final VoidCallback onCreatePressed;
  final VoidCallback onCleanPressed;

  final Function(String) updateMapaOrigin;
  final Function(String) updateMapaDestino;

  String dataOrigin = "";
  String dataDestino = "";

  UbicacionSelector({
    Key? key,
    required this.onCreatePressed,
    required this.onCleanPressed,
    required this.updateMapaOrigin,
    required this.updateMapaDestino
  }) : super(key: key);

  void updateOrigin(String dataOrigin){
    this.dataOrigin = dataOrigin;
    updateMapaOrigin(this.dataOrigin);
    //print(this.dataOrigin);
  }
  void updateDestino(String dataDestino){
    this.dataDestino = dataDestino;
    updateMapaDestino(this.dataDestino);
    //print(this.dataDestino);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.onSecondary,
      ),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children:  [
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 5),
                    child: DropdownUbication(
                        updateData: updateOrigin
                    ),
                  ),
                  const Icon(Icons.arrow_forward_rounded),
                  const Text(
                    ' . . . ',
                    style: TextStyle(fontSize: 40.0),
                  ),
                  //Icon(Icons.arrow_forward_rounded),
                  Padding(
                    padding: const EdgeInsets.only(right: 35),
                    child: DropdownUbication(
                      updateData: updateDestino
                    ),
                  ),
                ],
              )),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 10,
                ),
                child: MaterialButton(
                  onPressed: onCleanPressed,
                  color: Colors.deepPurpleAccent,
                  child: const Text(
                    'Limpiar',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: onCreatePressed,
                color: Colors.teal,
                child: const Text(
                  'Crear Ruta',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
