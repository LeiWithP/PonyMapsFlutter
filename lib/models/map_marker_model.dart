import 'package:latlong2/latlong.dart';

class MapMarker {
  final String? image;
  final String title;
  final LatLng location;

  MapMarker({
    required this.image,
    required this.title,
    required this.location,
  });
}

final mapMarkers = [
  MapMarker(
      image: 'assets/pony_plaza.jpg',
      title: 'Alexander The Great Restaurant',
      location: LatLng(19.72299, -101.18582)),
  MapMarker(
      image: 'assets/pony_plaza.jpg',
      title: 'Mestizo Mexican Restaurant',
      location: LatLng(19.72325, -101.18541)),
  MapMarker(
      image: 'assets/pony_plaza.jpg',
      title: 'The Shed',
      location: LatLng(19.72344, -101.18505)),
  MapMarker(
      image: 'assets/pony_plaza.jpg',
      title: 'Gaucho Tower Bridge',
      location: LatLng(19.72318, -101.18493)),
  MapMarker(
    image: 'assets/pony_plaza.jpg',
    title: 'Bill\'s Holborn Restaurant',
    location: LatLng(19.72298, -101.18509)
  ),
];
