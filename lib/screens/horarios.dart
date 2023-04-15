import 'package:flutter/material.dart';
import 'package:ponymapscross/cards/horarioCard.dart';

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
        const SizedBox(height: 10),
        Container(
          height: 70,
          decoration: BoxDecoration(
            /*gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.onSecondary,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              transform: GradientRotation(0.3 * 3.14),
            ), */
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(15.0),
          ),
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
        Expanded(
            child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return HorarioCard(title: 'Materia', schedule: '??:?? - ??:??',);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListWheelScrollView(double w, IconData icon, List<String> items, Function(String) onSelectedItemChanged) {
    return SizedBox(
      width: w,
      child: ListWheelScrollView(
        itemExtent: 28,
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
