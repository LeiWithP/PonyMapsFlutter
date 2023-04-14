import 'package:flutter/material.dart';
import 'package:ponymapscross/components/dropdownUbication.dart';

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
              children: const [
                Padding(
                  padding: EdgeInsets.only(
                      left: 35,
                      right: 5
                  ),
                  child: DropdownUbication(),
                ),
                Icon(Icons.arrow_forward_rounded),
                Text(
                  ' . . . ',
                  style: TextStyle(fontSize: 40.0),
                ),
                //Icon(Icons.arrow_forward_rounded),
                Padding(
                  padding: EdgeInsets.only(right: 35),
                  child: DropdownUbication(),
                ),
              ],
            )
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 10,
                ),
                child: MaterialButton(
                  onPressed: (){},
                  color: Colors.deepPurpleAccent,
                  child: const Text(
                    'Limpiar',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: (){


                },
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
