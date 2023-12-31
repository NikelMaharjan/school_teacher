import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMap extends StatefulWidget {
  final double lat;
  final double long;

  ShowMap(this.lat, this.long);

  @override
  State<ShowMap> createState() => ShowMapState();
}

class ShowMapState extends State<ShowMap> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  Set<Marker> marker = {};

  @override
  void initState() {
    setState(() {
      marker.add(Marker(
          markerId: MarkerId('1'),
          position: LatLng(widget.lat, widget.long)
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: marker,
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(
          target: LatLng(widget.lat, widget.long),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),

    );
  }

}