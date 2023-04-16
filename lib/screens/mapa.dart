import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
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

class _MapaState extends State<Mapa> with TickerProviderStateMixin {
  bool showSelector = false;
  double containerHeight = 0;
  final mapController = MapController();

  PolylineLayer polylineLayer = PolylineLayer(
    polylines: [],
  );
  List<LatLng> polylinePoints = [];

  int? selectedIndex;

  bool arrivedDest = false;
  bool activeRoute = false;
  late Timer _timer;

  late Position currentPos;

  @override
  Widget build(BuildContext context) {
    return PageStorage(
        bucket: PageStorageBucket(),
        child: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                  center: AppConstants.tecCampus1,
                  zoom: 17.0,
                  maxZoom: 18.0,
                  minZoom: 10.0,
                  /*bounds: AppConstants.boundariesCampus1,
                  maxBounds: AppConstants.boundariesCampus1,*/
                  onTap: (tapPosition, location) => _mapTapped(location)
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
              /*urlTemplate: "https://api.mapbox.com/styles/v1/angels0107/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",*/
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
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
            CurrentLocationLayer(
              followOnLocationUpdate: FollowOnLocationUpdate.once,
              turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
              /*style: const LocationMarkerStyle(
                marker: DefaultLocationMarker
                  child: Icon(
                    Icons.navigation,
                    color: Colors.white,
                  ),
                ),
                markerSize: Size(40, 40),
                markerDirection: MarkerDirection.heading,
              ),*/
            ),
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
                          _animatedMapMove(mapMarkers[i].location, 18);
                          selectedIndex = i;
                        },
                        onTap: () async {
                          //a();
                          /*ScaffoldMessenger.of(_).showSnackBar(const SnackBar(
                            content: Text('Normal Tap'),
                          ));*/

                          //polylinePoints.add(LatLng(19.72299, -101.18582));
                          //polylinePoints.add(LatLng(19.72325, -101.18541));
                          await getCurrentLocation();
                          await addCoordinates(LatLng(19.709611, -101.169254), LatLng(19.709773, -101.169428));
                          //print(polylinePoints.join(''));
                          addPolyline();
                          startLiveRouting();

                          /*showDialog(
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
                                  )));*/
                        },
                        onLongPress: () {
                          ScaffoldMessenger.of(_).showSnackBar(const SnackBar(
                            content: Text('Long Tap'),
                          ));
                          startLiveRouting();
                        },
                        child: AnimatedScale(
                            duration: const Duration(microseconds: 500),
                            scale: selectedIndex == i ? 1 : 0.7,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: (selectedIndex == null)
                                  ? 1
                                  : (selectedIndex == i)
                                      ? 1
                                      : 0.5,
                              child: SvgPicture.asset(
                                'assets/icons/map_marker.svg',

                              ),
                            )),
                        /*child: SvgPicture.asset(
                          'assets/icons/map_marker.svg',
                        ),*/
                      );
                    },
                  ),
              ],
            ),
            MarkerLayer(
              markers: [
                  Marker(
                    height: 30,
                    width: 30,
                    point: AppConstants.tecCampus1,
                    builder: (_) {
                      return GestureDetector(
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

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  void startLiveRouting() {
    const secs = Duration(milliseconds: 3 * 500);
    _timer = Timer.periodic(
      secs,
      (Timer timer) async {
        if ( activeRoute == false || arrivedDest == true) {
          setState(() {
            timer.cancel();
          });
        } else {

          getCurrentLocation();
          newLineCoordinates();

          addPolyline();


          /*
          setState(() {

          });*/
        }
      },
    );
  }

  void newLineCoordinates(){

    var actualPos = LatLng(currentPos.latitude, currentPos.longitude);

    polylinePoints.removeAt(0);
    polylinePoints.insert(0, actualPos);

    var nextPos = polylinePoints[1];

    Distance distance = const Distance();

    double meters = distance.as(LengthUnit.Meter, actualPos, nextPos);
    double dist = 5.0;

    if (meters <= dist) {

      if( polylinePoints.isNotEmpty ) polylinePoints.removeAt(1);

    }

    if (polylinePoints.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Arrived'),
      ));
      arrivedDest = true;
    }
  }

  ///
  /// Routing
  ///

  Future<void> addCoordinates(LatLng origen, LatLng destino) async {
    final apiData = await fetchApiData(origen, destino);
    var coordinates = apiData.routes.first.geometry.coordinates;

    polylinePoints = coordinates
        .map((coordinate) => LatLng(coordinate.last, coordinate.first))
        .toList();

    activeRoute = true;
    arrivedDest = false;
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

  Future<ApiResponse> fetchApiData(LatLng origen, LatLng destino) async {
    var accessToken = AppKeys.mapBoxAccessToken;

    var oriLng = origen.longitude;
    var oriLat = origen.latitude;

    var destLng = destino.longitude;
    var destLat = destino.latitude;

    String urlTemplate =
        "https://api.mapbox.com/directions/v5/mapbox/walking/$oriLng,$oriLat;$destLng,$destLat?alternatives=false&geometries=geojson&overview=simplified&steps=false&access_token=$accessToken";

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

  ///
  /// Location
  ///

  Future<void> getCurrentLocation() async {

    currentPos = await _determinePosition();
    /*
    String message = 'Lat ' + currentPos.latitude.toString() + " Lng " + currentPos.longitude.toString();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));*/
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _mapTapped(LatLng location) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Map Tapped'),
    ));
    selectedIndex = null;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

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

    List<Routes> routes =
        routeList.map((route) => Routes.fromJson(route)).toList();
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
