import 'package:flutter/material.dart';
import 'package:ponymapscross/Cards/UbicacionCard.dart';


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
          imageUrl: 'https://picsum.photos/seed/$index/300/150',
          onTap: () {
            // Handle the card tap event here
          },
        );
      },
    );
  }
}
