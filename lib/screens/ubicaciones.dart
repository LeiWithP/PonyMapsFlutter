import 'package:flutter/material.dart';
import 'package:ponymapscross/cards/ubicacionCard.dart';
import 'package:provider/provider.dart';
import 'package:ponymapscross/screens/mapa.dart';


import '../providers/SearchQueryProvider.dart';

class Ubicaciones extends StatefulWidget {
  final List<Map<String, String>> items;
  final void Function(int, String) onOpenLocation;

  const Ubicaciones({Key? key, required this.items, required this.onOpenLocation,}) : super(key: key);

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
            final searchPool = item['related'] ?? '';
            final onOpenLocation = widget.onOpenLocation;

            if (searchQuery.isNotEmpty &&
                !title.toLowerCase().contains(searchQuery.toLowerCase()) &&
                !subtitle.toLowerCase().contains(searchQuery.toLowerCase()) &&
                !areas.toLowerCase().contains(searchQuery.toLowerCase()) &&
                !searchPool.toLowerCase().contains(searchQuery.toLowerCase())) {
              return Container(); // Return an empty container if the item doesn't match the search query
            }
            if (searchQuery.isNotEmpty &&
                searchQuery.length < 3 &&
                !(title.toLowerCase() == (searchQuery.toLowerCase()))) {
              return Container(); // Return an empty container if the item doesn't match the search query
            }

            return UbicacionCard(
              title: title,
              subtitle: subtitle,
              areas: areas,
              imagePath: imagePath,
              onOpenLocation: onOpenLocation,
            );
          },
        ),
    );
  }
}
