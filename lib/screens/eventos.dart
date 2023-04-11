import 'package:flutter/material.dart';
import 'package:ponymapscross/cards/eventosCard.dart';


class Eventos extends StatelessWidget {
  final List<Map<String, String>> items;

  const Eventos({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return EventosCard(
          title: items[index]['title'] ?? 'Desconocido', // Use the 'name' value as the title
          date: items[index]['date'] ?? '', // Use the 'description' value as the subtitle
          location: items[index]['location'] ?? '',
          description: items[index]['description'] ?? '',
          imageUrl: 'https://picsum.photos/300/150',
        );
      },
    );
  }
}
