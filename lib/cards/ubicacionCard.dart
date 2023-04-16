import 'package:flutter/material.dart';

class UbicacionCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String areas;
  final String imagePath;

  const UbicacionCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.areas,
    required this.imagePath,
  }) : super(key: key);

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<UbicacionCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      color: Theme.of(context).colorScheme.secondaryContainer,
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
                height: isExpanded ? 250.0 : 150.0,
                child: Image.asset(
                  widget.imagePath,
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
                widget.subtitle,
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: isExpanded ? null : 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.areas,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
