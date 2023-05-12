import 'package:flutter/material.dart';
import 'package:ponymapscross/cards/ubicacionCard.dart';


class Ubicaciones extends StatelessWidget {
  final List<Map<String, String>> items;

  const Ubicaciones({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageStorage(
        bucket: PageStorageBucket(),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return UbicacionCard(
              title: items[index]['building'] ?? 'Desconocido',
              subtitle: items[index]['name'] ?? '',
              areas: items[index]['areas'] ?? '',
              imagePath: items[index]['photo'] ?? 'assets/pony_plaza.jpg',
            );
          },
        ),
    );
  }
}
