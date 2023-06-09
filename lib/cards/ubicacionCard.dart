import 'package:flutter/material.dart';
import 'package:ponymapscross/main.dart';
import 'package:sizer/sizer.dart';

class UbicacionCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String areas;
  final String imagePath;
  final void Function(int, String) onOpenLocation;

  const UbicacionCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.areas,
    required this.imagePath,
    required this.onOpenLocation,
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
        onLongPress: () {
          widget.onOpenLocation(0, widget.title);
          /*Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Mapa()),
          );*/
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
              leading:  Text(
                widget.title,
                style: TextStyle(fontSize: 30.sp),
              ),
              title: Text(
                widget.subtitle,
                style: TextStyle(fontSize: 18.sp),
              ),
              minVerticalPadding: 10.0,

            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: isExpanded ? null : 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [

                    ExpansionTile(
                      leading: Icon( Icons.layers),
                      title: Text('Departamentos'),
                      children: <Widget>[
                        Text(widget.areas),
                      ],

                    ),

                  ],

                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
