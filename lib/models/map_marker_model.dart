import 'package:latlong2/latlong.dart';

class MapMarker {
  final String? image;
  final String title;
  final String description;
  final LatLng location;

  MapMarker({
    this.image,
    required this.title,
    required this.description,
    required this.location,
  });
}

final mapMarkers = [
  ///
  /// Campus 1
  ///
  MapMarker(
      image: 'assets/pony_plaza.jpg',
      title: 'A',
      description: 'Edificio Administrativo',
      location: LatLng(19.72299, -101.18582)),
  MapMarker(
      image: 'assets/pony_plaza.jpg',
      title: 'B',
      description: 'Laboratorio De Química Analítica',
      location: LatLng(19.72325, -101.18541)),
  MapMarker(
      image: 'assets/pony_plaza.jpg',
      title: 'CH',
      description: 'Departamento De Ingeniera Industrial Y Bioquímica',
      location: LatLng(19.72344, -101.18505)),
  MapMarker(
      image: 'assets/pony_plaza.jpg',
      title: 'C',
      description: 'Coordinación De Ingles',
      location: LatLng(19.72318, -101.18493)),
  MapMarker(
      image: 'assets/pony_plaza.jpg',
      title: 'D',
      description: 'Laboratorio De Ingeniera Bioquímica',
      location: LatLng(19.72298, -101.18509)),
  MapMarker(
      image: 'assets/pony_plaza.jpg',
      title: 'E',
      description: 'Aulas Y Taller De Dibujo',
      location: LatLng(19.72273, -101.18529)),
  MapMarker(
      image: 'assets/pony_plaza.jpg',
      title: 'F',
      description: 'Sala Audiovisual No. 1 Y Aulas',
      location: LatLng(19.72252, -101.18549)),
  MapMarker(
      image: 'assets/pony_plaza.jpg',
      title: 'G',
      description: 'Laboratorio Ing. Mecánica Y Eléctrica',
      location: LatLng(19.72245, -101.18487)),
  MapMarker(
      image: 'assets/pony_plaza.jpg',
      title: 'H',
      description: 'Unidad Deportiva Y Tribunas',
      location: LatLng(19.7224, -101.18417)),
  MapMarker(
      image: 'assets/pony_plaza.jpg',
      title: 'I',
      description: 'Departamento De Sistemas Y Computación',
      location: LatLng(19.72224, -101.18545)),


];
