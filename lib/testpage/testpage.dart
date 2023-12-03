import 'dart:async';
import 'package:eschool_teacher/testpage/show_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:dart_ipify/dart_ipify.dart';

class TrackerPage extends StatefulWidget {
  final String employeeName;
  final String employeePhoto;
  TrackerPage({required this.employeeName,required this.employeePhoto});
  @override
  _TrackerPageState createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {


  static CollectionReference locationDb = FirebaseFirestore.instance.collection('Locations');






  // Add variables to hold the current position and location services status
  Position? _currentPosition;
  String _locationServiceStatus = '';
  bool _locationUpdatesEnabled = false;
  StreamSubscription<Position>? _positionStreamSubscription;
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  Set<Marker> marker = {};


  @override
  void initState() {

    _checkLocationServices();
    setState(() {
      marker.add(Marker(
          markerId: MarkerId(widget.employeeName),
          position: LatLng(_currentPosition?.latitude ?? 0, _currentPosition?.longitude ?? 0)
      ));
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // Cancel the position stream subscription when the widget is disposed
    _positionStreamSubscription?.cancel();
  }

  // Define a function to check the status of location services
  Future<void> _checkLocationServices() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    setState(() {
      _locationServiceStatus = serviceEnabled ? 'Enabled' : 'Disabled';
    });
  }




  // Define a function to start or stop listening for location updates
  void _toggleLocationUpdates(bool enabled) async {
    if (enabled)  {
      DateTime now = DateTime.now();
      int hour = now.hour;
      int minute = now.minute;

      print('$hour,$minute');

      final locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        // Handle denied permission
        return;
      }
      GoogleMapController googleMapController = await _controller.future;
      _positionStreamSubscription =
          Geolocator.getPositionStream().listen((Position position) async {
            if (((hour >= 7 && minute >= 0 ) && (hour <= 12 && minute <= 30 ) )){
              await Future.delayed(Duration(seconds: 4));
              await locationDb.doc('rfBqlaPp3spu4r7Tz3gj').update({
                'lat' : position.latitude,
                'long' : position.longitude
              });}

           if (((hour >= 15 && minute >= 0 ) && (hour <= 18 && minute <= 30 ) )){
              await Future.delayed(Duration(seconds: 4));
              await locationDb.doc('rfBqlaPp3spu4r7Tz3gj').update({
                'lat' : position.latitude,
                'long' : position.longitude
              });}




            googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
               zoom: 15,
                target: LatLng(position.latitude, position.longitude))));
            setState(() {
              _currentPosition = position;
              marker.add(Marker(
                  markerId: MarkerId(widget.employeeName),
                  position: LatLng(_currentPosition?.latitude ?? 0, _currentPosition?.longitude ?? 0)
              ));
            });
          });
    } else {
      _positionStreamSubscription?.cancel();
      _positionStreamSubscription = null;
    }
    setState(() {
      _locationUpdatesEnabled = enabled;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Tracker Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Location services status: $_locationServiceStatus'),
            SizedBox(height: 16),
            Text('Latitude: ${_currentPosition?.latitude ?? ''}'),
            SizedBox(height: 16),
            Text('Longitude: ${_currentPosition?.longitude ?? ''}'),
            SizedBox(height: 16),
            Switch(
              value: _locationUpdatesEnabled,
              onChanged: _toggleLocationUpdates,
            ),
            Text('Location updates enabled'),
            TextButton(
                onPressed: ()async {},

                child: Text('Show on map')
            ),
            Container(
              height: 300.h,
              width: 350.w,
              child: GoogleMap(
                markers: marker,
                mapType: MapType.normal,
                initialCameraPosition:  CameraPosition(
                  target: LatLng(_currentPosition?.latitude ?? 0, _currentPosition?.longitude ?? 0),
                  zoom: 15,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
