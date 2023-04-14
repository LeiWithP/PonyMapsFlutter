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
      title: 'A',
      location: LatLng(19.72299, -101.18582)),
  MapMarker(
      image: 'assets/pony_plaza.jpg',
      title: 'B',
      location: LatLng(19.72325, -101.18541)),
  MapMarker(
      image: 'assets/pony_plaza.jpg',
      title: 'CH',
      location: LatLng(19.72344, -101.18505)),
  MapMarker(
      image: 'assets/pony_plaza.jpg',
      title: 'C',
      location: LatLng(19.72318, -101.18493)),
  MapMarker(
    image: 'assets/pony_plaza.jpg',
    title: 'D',
    location: LatLng(19.72298, -101.18509)
  ),
];
