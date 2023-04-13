import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

import 'package:ponymapscross/constants/app_constants.dart';
import 'package:sizer/sizer.dart';

import '../cards/ubicacionCard.dart';
import '../constants/app_keys.dart';
import '../models/map_marker_model.dart';

class Mapa extends StatefulWidget {
  const Mapa({Key? key}) : super(key: key);
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  bool showSelector = false;
  double containerHeight = 0;
  final mapController = MapController();

  PolylineLayer polylineLayer = PolylineLayer(
    polylines: [],
  );
  List<LatLng> polylinePoints = [];

  late PolylineLayer polyLineLayer;
  late Polyline currentPolyline;

  double containerHeight = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            center: AppConstants.tecCampus1,
            zoom: 17.0,
            maxZoom: 18.0,
            minZoom: 16.0,
            bounds: AppConstants.boundariesCampus1,
            maxBounds: AppConstants.boundariesCampus1,
          ),
          /*
          nonRotatedChildren: [
            // This does NOT fulfill Mapbox's requirements for attribution
            // See https://docs.mapbox.com/help/getting-started/attribution/

            AttributionWidget.defaultWidget(
              alignment: Alignment.bottomLeft,
              source: '© Mapbox © OpenStreetMap',
              onSourceTapped: () async {
                // Requires 'url_launcher'
                if (!await launchUrl(Uri.parse(
                    "https://docs.mapbox.com/help/getting-started/attribution/"))) {
                  if (kDebugMode) print('Could not launch URL');
                }
              },
            ),
          ],*/
          children: [
            TileLayer(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/angels0107/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
              additionalOptions: const {
                'mapStyleId': AppKeys.mapBoxStyleId,
                'accessToken': AppKeys.mapBoxAccessToken,
              },
              userAgentPackageName: 'com.example.app',
            ),
            /*
            polyLineLayer = PolylineLayer(
              polylineCulling: false,
              saveLayers: true,
              polylines: [
                Polyline(
                  points: [

                    LatLng(19.72299, -101.18582),
                    LatLng(19.72325, -101.18541),
                    LatLng(19.72344, -101.18505),


                  ],
                  color: Colors.blue,
                  strokeWidth: 5.0,
                )
              ],
            ),*/
            polylineLayer,
            MarkerLayer(
              markers: [
                for (int i = 0; i < mapMarkers.length; i++)
                  Marker(
                    height: 30,
                    width: 30,
                    point: mapMarkers[i].location,
                    builder: (_) {
                      return GestureDetector(
                        onDoubleTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                  title: Text(mapMarkers[i].title),
                                  content: UbicacionCard(
                                    title: mapMarkers[i].title,
                                    // Use the 'name' value as the title
                                    subtitle: mapMarkers[i].title,
                                    // Use the 'description' value as the subtitle
                                    areas: mapMarkers[i].title,
                                    imagePath: 'assets/pony_plaza.jpg',
                                  )));
                        },
                        onTap: () {
                          //a();

                          /*ScaffoldMessenger.of(_).showSnackBar(const SnackBar(
                            content: Text('Normal Tap'),
                          ));*/
                        },
                        onLongPress: () {
                          ScaffoldMessenger.of(_).showSnackBar(const SnackBar(
                            content: Text('Long Tap'),
                          ));
                        },
                        child: SvgPicture.asset(
                          'assets/icons/map_marker.svg',
                        ),
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 10.0,
          right: 10.0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0, right: 0),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  showSelector = !showSelector;
                  containerHeight = showSelector ? 200.0 : 0.0;
                });
              },
              child: const Icon(Icons.directions),
            ),
          ),
        ),
        AnimatedPositioned(
          bottom: showSelector ? 10 : -200,
          right: 70,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOutBack,
          child: UbicacionSelector(),
        ),
      ],
    );
  }

  void addPolyline() {
    setState(() {
      polylineLayer = PolylineLayer(
        polylines: [
          Polyline(
            points: polylinePoints,
            color: Colors.blue,
            strokeWidth: 4.0,
          ),
        ],
      );

      showSelector = false;
    });
  }
}
