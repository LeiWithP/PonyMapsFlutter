import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:ponymapscross/constants/app_constants.dart';
import 'package:sizer/sizer.dart';
import '../components/ubicacion_selector.dart';
import '../constants/app_keys.dart';
import '../models/map_marker_model.dart';
import 'package:http/http.dart' as http;
import '../models/ubicacion_models.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:flutter/services.dart'
    show rootBundle; // Biblioteca para leer archivos locales

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

  MarkerLayer markerLayer = MarkerLayer(
    markers: [],
  );

  int? selectedIndex;

  bool arrivedDest = false;
  bool activeRoute = false;
  late Timer _timer;

  late Position currentPos;

  Map<String, MapMarker> places = {};

  late LatLng origin;
  late LatLng destino;

  String dataOrigin = "A";
  String dataDestino = "A";

  List<MapMarker> markers = [];

  /*
  origin = places[dataOrigin]!.location;
  destino = places[dataDestino]!.location;*/

  void updateOrigin(String dataOrigin) {
    this.dataOrigin = dataOrigin;
    print("${this.dataOrigin}hola");
  }

  void updateDestino(String dataDestino) {
    this.dataDestino = dataDestino;

    print(this.dataDestino + "hola");
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      markers = await loadMapMarkers();

      for (int i = 0; i < markers.length; i++) {
        //print(mapMarkers[i].title);
        //print("Bruhhhhhhh");
        places[markers[i].title] = markers[i];
      }


    });


  }

  Future<List<MapMarker>> loadMapMarkers() async {
    String jsonString = await _loadJsonAsset(); // Lee el archivo JSON

    final jsonData = json.decode(jsonString); // Decodifica el JSON

    for (var item in jsonData) {
      //var lat = double.tryParse(item['Lat']);
      //var lng = double.tryParse(item['Lng']);
      print("Bruhhhhhhh");

      MapMarker marker = MapMarker(
        image: item['Image'] as String,
        title: item['Nombre'] as String,
        description: item['Descripcion'] as String,
        location: LatLng(item['Lat'], item['Lng']),
      );
      /*
      print(item['Nombre']);
      print(item['Descripcion']);
      print(item['Lat']  );
      print(item['Lng']  );*/

      places[marker.title] = marker;

      markers.add(marker);
    }

    return markers;
  }

  Future<String> _loadJsonAsset() async {
    return await rootBundle.loadString('assets/json/places.json');
  }

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
                  zoom: 14.5,
                  slideOnBoundaries: true,
                  maxZoom: 18.4,
                  minZoom: 14.5,
                  bounds: AppConstants.boundariesCampus1,
                  maxBounds: AppConstants.boundariesCampus1,
                  onTap: (tapPosition, location) => _mapTapped(location),
                  onMapReady: () {
                    setState(() {

                    });
                    _animatedMapMove(AppConstants.tecCampus1, 14.5);
                  },
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

               /* TileLayer(
                    maxNativeZoom: 22,
                    /*urlTemplate: "https://api.mapbox.com/styles/v1/angels0107/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                 urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  additionalOptions: const {
                    'mapStyleId': AppKeys.mapBoxStyleId,
                    'accessToken': AppKeys.mapBoxAccessToken,
                  },*/
                    userAgentPackageName: 'com.example.app',
                    tileProvider: CustomTileProvider(),
                    urlTemplate: '',

                    //tileProvider: CachedNetworkTileProvider(),
                    ),*/
                TileLayer(
                  tileProvider: CustomTileProvider(),
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/angels0107/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                  additionalOptions: const {
                    'mapStyleId': AppKeys.mapBoxStyleId,
                    'accessToken': AppKeys.mapBoxAccessToken,
                  }
                  ,
                  //urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  tileBuilder: (
                    context,
                    Widget tileWidget,
                    Tile tile,
                  ) {
                    final coords = tile.coords;
                    var urlTemplate =
                        "https://api.mapbox.com/styles/v1/angels0107/${AppKeys.mapBoxStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token=${AppKeys.mapBoxAccessToken}";
                    //var urlTemplate = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

                    return CachedNetworkImage(
                      imageUrl: urlTemplate
                          .replaceAll('{z}', coords.z.toInt().toString())
                          .replaceAll('{x}', coords.x.toInt().toString())
                          .replaceAll('{y}', coords.y.toInt().toString()),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    );
                  },
                ),
                polylineLayer,
                CurrentLocationLayer(
                  followOnLocationUpdate: FollowOnLocationUpdate.once,
                  turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
                ),

                markerLayer
                ,
                MarkerLayer(
                  markers: [
                    for (int i = 0; i < markers.length; i++)
                      Marker(
                        height: 25,
                        width: 25,
                        point: markers[i].location,
                        builder: (_) {
                          return GestureDetector(
                            onDoubleTap: () {
                              selectedIndex = i;
                              _animatedMapMove(markers[i].location, 18.4);

                              showDialog(
                                  context: context,
                                  builder: (_) => Dialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(0.0))),
                                        child: SizedBox(
                                          height: 50.h,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                markers[i].image!,
                                                fit: BoxFit.contain,
                                              ),
                                              Text(
                                                "Edificio ${markers[i].title}",
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                markers[i].description,
                                                style: TextStyle(fontSize: 10),
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Cerrar"))
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                            onTap: () {
                              selectedIndex = i;
                              _animatedMapMove(markers[i].location, 18.4);

                             /* Future.delayed(const Duration(seconds: 1), () {
                                // <-- Delay here
                                setState(() {
                                  selectedIndex = i;
                                });
                              });*/
                            },
                            onLongPress: () {
                              ScaffoldMessenger.of(_)
                                  .showSnackBar(const SnackBar(
                                content: Text('Long Tap'),
                              ));
                            },
                            /*
                            child: AnimatedScale(
                                duration: const Duration(microseconds: 500),
                                scale: (selectedIndex == null)
                                    ? 0.7
                                    : (selectedIndex == i)
                                        ? 1
                                        : 0.7,
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
                                )),*/
                            child: SvgPicture.asset(
                          'assets/icons/map_marker.svg',
                            ),
                          );
                        },
                      ),
                  ],
                ),
                /*
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(19.72176, -101.18544),
                      width: 80,
                      height: 80,
                      builder: (context) => FlutterLogo()
                    ),
                  ],
                ),*/

              ],
            ),
            Positioned(
              bottom: 2.5.h,
              right: 2.5.w,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0, right: 0),
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    setState(() {
                      showSelector = !showSelector;
                      containerHeight = showSelector ? 20.0.h : 0.0.h;
                    });
                  },
                  child: const Icon(Icons.directions, color: Colors.black),
                ),
              ),
            ),
            AnimatedPositioned(
              bottom: showSelector ? 10 : -200,
              right: 19.0.w,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOutBack,
              child: UbicacionSelector(
                updateMapaOrigin: updateOrigin,
                updateMapaDestino: updateDestino,
                onCreatePressed: () async {
                  origin = places[dataOrigin]!.location;
                  destino = places[dataDestino]!.location;

                  print("a");
                  print(origin);
                  print(destino);

                  await getRoute(origin, destino);
                  /*ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Arrived'),
                  ));*/
                },
                onCleanPressed: () {
                  cleanRoute();
                },
              ),
            ),
          ],
        ));
  }

  ///
  /// Routing
  ///

  ///
  /// Miscelaneous
  ///

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

  void cleanRoute() {
    polylinePoints = [];
    addPolyline();

    activeRoute = false;
    arrivedDest = false;
  }

  Future<void> getRoute(LatLng origin, LatLng dest) async {
    //await getCurrentLocation();
    await addCoordinates(origin, dest);
    //print(polylinePoints.join(''));
    addPolyline();
    //startLiveRouting();
  }

  void startLiveRouting() {
    const secs = Duration(milliseconds: 3 * 500);
    _timer = Timer.periodic(
      secs,
      (Timer timer) async {
        if (activeRoute == false || arrivedDest == true) {
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

  void newLineCoordinates() {
    var actualPos = LatLng(currentPos.latitude, currentPos.longitude);

    polylinePoints.removeAt(0);
    polylinePoints.insert(0, actualPos);

    var nextPos = polylinePoints[1];

    Distance distance = const Distance();

    double meters = distance.as(LengthUnit.Meter, actualPos, nextPos);
    double dist = 5.0;

    if (meters <= dist) {
      if (polylinePoints.isNotEmpty) polylinePoints.removeAt(1);
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

    _animatedMapMove(origen, 18.4);

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
    /*ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Map Tapped'),
    ));*/
    selectedIndex = null;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class CustomTileProvider extends TileProvider {
  @override
  ImageProvider getImage(Coords<num> coords, TileLayer options) {
    final url =
        'https://api.mapbox.com/styles/v1/angels0107/${AppKeys.mapBoxStyleId}/tiles/256/${coords.z.toInt()}/${coords.x.toInt()}/${coords.y.toInt()}@2x?access_token=${AppKeys.mapBoxAccessToken}';
    //'https://tile.openstreetmap.org/${coords.z.toInt()}/${coords.x.toInt()}/${coords.y.toInt()}.png';
    return CachedNetworkImageProvider(url,
        cacheManager: CacheManager(
          Config(
            'cacheKey',
            stalePeriod: const Duration(days: 30),
          ),
        ));
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
