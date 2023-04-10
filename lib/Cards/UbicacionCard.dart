import 'package:flutter/material.dart';

class UbicacionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback? onTap;

  const UbicacionCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      color: Theme.of(context).colorScheme.onSecondary,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: SizedBox(
                height: 130.0,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              title: Text(
                title,
                style: const TextStyle(fontSize: 40.0), // set the font size to 20
              ),
              subtitle: Text(
                subtitle,
                style: const TextStyle(fontSize: 20.0), // set the font size to 20
              ),
            ),
          ],
        ),
      ),
    );
  }
}
