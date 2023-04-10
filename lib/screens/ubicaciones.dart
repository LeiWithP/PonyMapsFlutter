import 'package:flutter/material.dart';
import 'package:ponymapscross/cards/ubicacionCard.dart';


class Ubicaciones extends StatelessWidget {
  final List<Map<String, String>> items;

  const Ubicaciones({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return UbicacionCard(
          title: items[index]['building'] ?? 'Desconocido', // Use the 'name' value as the title
          subtitle: items[index]['name'] ?? '', // Use the 'description' value as the subtitle
          imagePath: 'assets/pony_plaza.jpg',
        );
      },
    );
  }
}
