// ignore_for_file: unused_field, unused_local_variable, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:task_googlemap0tracking/constants.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  static const LatLng staringLocation = LatLng(23.8191, 90.4526);
  static const LatLng destinationLocation = LatLng(23.8041, 90.4152);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocation = location;
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(staringLocation.latitude, staringLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      });
      setState(() {});
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Traking position',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: currentLocation == null ? const Center(child: Text('Loading.....')):
      GoogleMap(
        initialCameraPosition:
            CameraPosition(target: staringLocation, zoom: 12.5),
        polylines: {
          Polyline(
              polylineId: PolylineId('Routes'),
              points: polylineCoordinates,
              color: primaryColor,
              width: 6),
        },
        markers: {
          Marker(
            markerId: MarkerId('currentLocation'),
            position: LatLng(
              currentLocation!.latitude!,currentLocation!.longitude!,
            ),
          ),
          Marker(markerId: MarkerId("start"), position: staringLocation),
          Marker(markerId: MarkerId("end"), position: destinationLocation),
        },
      ),
    );
  }
}
