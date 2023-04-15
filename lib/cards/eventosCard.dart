import 'package:flutter/material.dart';

class EventosCard extends StatefulWidget {
  final String title;
  final String date;
  final String location;
  final String description;
  final String imageUrl;

  const EventosCard({
    Key? key,
    required this.title,
    required this.date,
    required this.location,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<EventosCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      color: Theme.of(context).colorScheme.onSecondary,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: InkWell(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: isExpanded ? 200.0 : 160.0,
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              title: Text(
                widget.title,
                style: const TextStyle(fontSize: 40.0),
              ),
              subtitle: Text(
                widget.date,
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: isExpanded ? 150.0 : 0.0,
              child: isExpanded
                  ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Text(
                    widget.description,
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
