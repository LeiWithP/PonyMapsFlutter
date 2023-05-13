import 'package:flutter/material.dart';
import 'package:ponymapscross/cards/ubicacionCard.dart';
import 'package:provider/provider.dart';

import '../providers/SearchQueryProvider.dart';


class Ubicaciones extends StatefulWidget {
  final List<Map<String, String>> items;

  const Ubicaciones({Key? key, required this.items}) : super(key: key);

  @override
  _UbicacionesState createState() => _UbicacionesState();
}


class _UbicacionesState extends State<Ubicaciones> {
@override
  Widget build(BuildContext context) {
    final searchQuery = Provider.of<SearchQueryProvider>(context).searchQuery;
    return PageStorage(
        bucket: PageStorageBucket(),
        child: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            final title = item['building'] ?? 'Desconocido';
            final subtitle = item['name'] ?? '';
            final areas = item['areas'] ?? '';
            final imagePath = item['photo'] ?? 'assets/pony_plaza.jpg';

            if (searchQuery.isNotEmpty &&
                !title.toLowerCase().contains(searchQuery.toLowerCase()) &&
                !subtitle.toLowerCase().contains(searchQuery.toLowerCase()) &&
                !areas.toLowerCase().contains(searchQuery.toLowerCase())) {
              return Container(); // Return an empty container if the item doesn't match the search query
            }

            return UbicacionCard(
              title: title,
              subtitle: subtitle,
              areas: areas,
              imagePath: imagePath,
            );
          },
        ),
    );
  }
}
