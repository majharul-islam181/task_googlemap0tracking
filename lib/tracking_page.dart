// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  static const LatLng staringLocation = LatLng(23.8191, 90.4526);
  static const LatLng destinationLocation = LatLng(23.8041, 90.4152);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Traking position',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition:
           CameraPosition(target: staringLocation, zoom: 12),
        markers: {
          Marker(markerId: MarkerId("start"),position: staringLocation),
          Marker(markerId: MarkerId("end"),position: destinationLocation),
        },
      ),
    );
  }
}
