import 'package:flutter/material.dart';

import '../cards/ubicacionCard.dart';
import '../settings/testData.dart';

class Horarios extends StatefulWidget {
  const Horarios({Key? key}) : super(key: key);

  @override
  _HorariosState createState() => _HorariosState();
}

class _HorariosState extends State<Horarios> {
  final List<Map<String, String>> items = buildings;
  final List<String> _list1 = buildings.map((e) => e["building"]!).toList();
  final List<String> _list2 = [
    'F1',
    'F2',
    'F3',
    'F4',
    'F5',
    'F6',
    'F7',
    'F8',
  ];
  final List<String> _days = [
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sabado',
    'Domingo',
  ];

  String _selectedItem1 = '';
  String _selectedItem2 = '';
  String _selectedDay = '';

  @override
  void initState() {
    super.initState();
    _selectedDay = _days[0];
    _selectedItem1 = _list1[0];
    _selectedItem2 = _list2[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return UbicacionCard(
                title: items[index]['building'] ?? 'Desconocido', // Use the 'name' value as the title
                subtitle: items[index]['name'] ?? '', // Use the 'description' value as the subtitle
                areas: items[index]['areas'] ?? '- Direccion\n- Departamento De Vinculacion\n- Oficina De Oficialidad Paqueteria\n- Departamento De Desarrollo Academico\n- Recursos Humanos\n- Servicio Medico\n- Departamento De Servicios Escolares\n- Departamento de Comunicacion y Difusion\n- Recursos Financieros\n- DEP: Division de Estudios Profesionales\n- DEPI: Division de Estudios de Posgrado e Investigacion"',
                imagePath: 'assets/pony_plaza.jpg',
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 60,
          color: Theme.of(context).colorScheme.onSecondary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildListWheelScrollView(75, Icons.account_balance_outlined, _list1, (value) {
                setState(() {
                  _selectedItem1 = value;
                });
              }),
              _buildListWheelScrollView(75, Icons.door_back_door_outlined, _list2, (value) {
                setState(() {
                  _selectedItem2 = value;
                });
              }),
              _buildListWheelScrollView(150, Icons.calendar_month_outlined, _days, (value) {
                setState(() {
                  _selectedDay = value;
                });
              }),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildListWheelScrollView(double w, IconData icon, List<String> items, Function(String) onSelectedItemChanged) {
    return SizedBox(
      width: w,
      child: ListWheelScrollView(
        itemExtent: 30,
        diameterRatio: 1,
        physics: FixedExtentScrollPhysics(),
        children: items
            .map(
              (item) => Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(icon),
                  ),
                  Text(
                    item,
                    style: const TextStyle(fontSize: 22),
                  ),
                ],
              )
        ).toList(),
        onSelectedItemChanged: (index) {
          onSelectedItemChanged(items[index]);
        },
      ),
    );
  }
}
