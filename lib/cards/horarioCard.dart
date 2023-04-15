import 'package:flutter/material.dart';

class HorarioCard extends StatelessWidget {
  final String title;
  final String schedule;

  HorarioCard({required this.title, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          /*gradient: LinearGradient(
            colors: [
              Colors.blueGrey[800]!,
              Colors.blueGrey[700]!,
              Colors.blueGrey[600]!,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),*/
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          subtitle: Text(
            schedule,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
