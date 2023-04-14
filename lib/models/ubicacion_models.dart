
class Routes {
  String weightName;
  double weight;
  double duration;
  double distance;
  List<Leg> legs;
  Geometry geometry;

  Routes({
    required this.weightName,
    required this.weight,
    required this.duration,
    required this.distance,
    required this.legs,
    required this.geometry
  });

  factory Routes.fromJson(Map<String, dynamic> json) {
    var legList = json['legs'] as List<dynamic>;

    List<Leg> legs = legList.map((leg) => Leg.fromJson(leg)).toList();

    return Routes(
      weightName: json['weight_name'],
      weight: json['weight'],
      duration: json['duration'],
      distance: json['distance'],
      legs: legs,
      geometry: Geometry.fromJson(json['geometry']),
    );
  }
}

class Leg {
  List<dynamic> viaWaypoints;
  List<Admin> admins;
  double weight;
  double duration;
  List<dynamic> steps;
  double distance;
  String summary;

  Leg({
    required this.viaWaypoints,
    required this.admins,
    required this.weight,
    required this.duration,
    required this.steps,
    required this.distance,
    required this.summary,
  });

  factory Leg.fromJson(Map<String, dynamic> json) {
    var adminList = json['admins'] as List<dynamic>;

    List<Admin> admins = adminList.map((admin) => Admin.fromJson(admin)).toList();

    return Leg(
      viaWaypoints: json['via_waypoints'],
      admins: admins,
      weight: json['weight'],
      duration: json['duration'],
      steps: json['steps'],
      distance: json['distance'],
      summary: json['summary'],
    );
  }
}

class Admin {
  String iso31661Alpha3;
  String iso31661;

  Admin({
    required this.iso31661Alpha3,
    required this.iso31661,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      iso31661Alpha3: json['iso_3166_1_alpha3'],
      iso31661: json['iso_3166_1'],
    );
  }
}

class Waypoint {
  double distance;
  String name;
  List<double> location;

  Waypoint({
    required this.distance,
    required this.name,
    required this.location,
  });

  factory Waypoint.fromJson(Map<String, dynamic> json) {
    return Waypoint(
      distance: json['distance'],
      name: json['name'],
      location: List<double>.from(json['location']),
    );
  }
}

class Geometry {
  final List<List<double>> coordinates;
  final String type;

  Geometry({
    required this.coordinates,
    required this.type
  });

  factory Geometry.fromJson(Map<String, dynamic> json) {
    var coordinatesList = json['coordinates'] as List;
    List<List<double>> coordinates = coordinatesList.map((coordinate) => List<double>.from(coordinate)).toList();

    return Geometry(
      coordinates: coordinates,
      type: json['type'],
    );
  }
}
