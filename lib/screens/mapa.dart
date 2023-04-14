import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

import 'package:ponymapscross/constants/app_constants.dart';
import 'package:sizer/sizer.dart';

import '../cards/ubicacionCard.dart';
import '../components/ubicacionSelector.dart';
import '../constants/app_keys.dart';
import '../models/map_marker_model.dart';

import 'package:http/http.dart' as http;

import '../models/ubicacion_models.dart';

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
              /*urlTemplate:
              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",*/
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
                              builder: (_) =>
                                  AlertDialog(
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
                        onTap: () async {
                          //a();
                          /*ScaffoldMessenger.of(_).showSnackBar(const SnackBar(
                            content: Text('Normal Tap'),
                          ));*/


                            await addCoordinates(LatLng(19.722989, -101.185827), LatLng(19.723173, -101.184928));
                            print(polylinePoints.join(''));
                           //polylinePoints.add(LatLng(19.72299, -101.18582));
                           //polylinePoints.add(LatLng(19.72325, -101.18541));
                            addPolyline();
                          //fetchData();
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
  ///
  /// Routing
  ///

  Future<void> addCoordinates(LatLng origen, LatLng destino) async {

    final apiData = await fetchApiData(origen, destino);
    var coordinates = apiData.routes.first.geometry.coordinates;

    polylinePoints = coordinates.map(
            (coordinate) =>
                LatLng( coordinate.last, coordinate.first)
    ).toList();



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

  Future<ApiResponse> fetchApiData(LatLng origen,LatLng destino) async {

    var accessToken = AppKeys.mapBoxAccessToken;

    var ori_lng =  origen.longitude;
    var ori_lat =  origen.latitude;

    var dest_lng =  destino.longitude;
    var dest_lat =  destino.latitude;

    String urlTemplate = "https://api.mapbox.com/directions/v5/mapbox/walking/$ori_lng,$ori_lat;$dest_lng,$dest_lat?alternatives=false&geometries=geojson&overview=simplified&steps=false&access_token=$accessToken";

    final apiUrl = Uri.parse(
        //'https://api.mapbox.com/directions/v5/mapbox/walking/-101.185404%2C19.723222%3B-101.185026%2C19.723415?alternatives=false&continue_straight=true&geometries=geojson&overview=simplified&steps=false&access_token=pk.eyJ1IjoiYW5nZWxzMDEwNyIsImEiOiJjbGJ2anRvdXAwdTMwM3ZxbzFkeWJndThqIn0.Ep3N8cDHH3Iwr9YLDgQn8g');
      urlTemplate);
    final response = await http.get(apiUrl);

    print("Get data");
    if (response.statusCode == 200) {
      // API call was successful
      final jsonResponse = json.decode(response.body);
      return ApiResponse.fromJson(jsonResponse);
    } else {
      // API call failed

      throw Exception('Failed to fetch data from API');
    }
  }
}
/*
  Future<void> fetchData() async {
    final url = Uri.parse(''
       // 'https://dummyjson.com/products/1'
        'https://api.mapbox.com/directions/v5/mapbox/walking/-101.185404%2C19.723222%3B-101.185026%2C19.723415?alternatives=false&continue_straight=true&geometries=geojson&overview=simplified&steps=false&access_token=pk.eyJ1IjoiYW5nZWxzMDEwNyIsImEiOiJjbGJ2anRvdXAwdTMwM3ZxbzFkeWJndThqIn0.Ep3N8cDHH3Iwr9YLDgQn8g'
    );


    final response = await http.get(url);

    if (response.statusCode == 200) {
      // The request was successful, parse the JSON response
      final jsonString = response.body;
      print(jsonString);
      // Do something with the JSON data
    } else {
      // The request failed with an error code, handle the error
      print('Request failed with status: ${response.statusCode}.');
    }
  }
*/




class ApiResponse {
  List<Routes> routes;
  List<Waypoint> waypoints;
  String code;
  String uuid;

  ApiResponse({
    required this.routes,
    required this.waypoints,
    required this.code,
    required this.uuid,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    var routeList = json['routes'] as List<dynamic>;
    var waypointList = json['waypoints'] as List<dynamic>;

    List<Routes> routes = routeList.map((route) => Routes.fromJson(route)).toList();
    List<Waypoint> waypoints =
    waypointList.map((waypoint) => Waypoint.fromJson(waypoint)).toList();

    return ApiResponse(
      routes: routes,
      waypoints: waypoints,
      code: json['code'],
      uuid: json['uuid'],
    );
  }
}