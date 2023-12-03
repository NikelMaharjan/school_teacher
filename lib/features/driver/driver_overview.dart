import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../constants/colors.dart';
import '../../api.dart';
import '../../utils/commonWidgets.dart';
import '../authentication/presentation/loginpage/teacher_login.dart';
import '../authentication/providers/auth_provider.dart';
import '../services/info_services.dart';




class DriverPage extends ConsumerStatefulWidget {
  @override
  _DriverPageState createState() => _DriverPageState();
}

class _DriverPageState extends ConsumerState<DriverPage> {

  static CollectionReference locationDb = FirebaseFirestore.instance.collection('Locations');

  bool isSwitched = false;
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
    final locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      setState(() {
        isSwitched = false;
      });
      return;
    }
    setState(() {
      _locationServiceStatus = serviceEnabled ? 'Enabled' : 'Disabled';
      isSwitched = serviceEnabled ? true : false ;
    });
  }



  void _toggleEnabled(bool enabled,int id) async {

    if(enabled){

      final locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return;
      }

      _positionStreamSubscription = Geolocator.getPositionStream().listen((Position position) async {

        // Check if a document with the specified driver_id exists in the database
        final querySnapshot = await locationDb.where('driver_id', isEqualTo: id).get();
        setState(() {
          _currentPosition = position;
        });
        if(querySnapshot.docs.isNotEmpty){
          final String docId = '${querySnapshot.docs.first.id}';
          print('id exists');
          print('doc id : ${querySnapshot.docs.first.id}');
          await locationDb.doc(docId).update({
            'lat':position.latitude,
            'long':position.longitude,
          });
        }
        else {
          print('it doesn\'t');
          // Add a new document to the database
          await locationDb.add({
            'lat' : position.latitude,
            'long' : position.longitude,
            'driver_id': id
          });
        }


      });




    }
    else{

      _positionStreamSubscription?.cancel();
      _positionStreamSubscription = null;
      setState(() {
        isSwitched = false;
      });

    }


  }


  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final infoData = ref.watch(employeeList(auth.user.token));
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver's Page"),
        actions: [
          IconButton(onPressed: () async {

            await ref.read(authProvider.notifier).userLogout(auth.user!.token);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Teacher_login()),
                  (route) => false,
            );

          }, icon: Icon(Icons.logout,color: Colors.white,))
        ],
        backgroundColor: primary, // set the primary color to blue
      ),
      backgroundColor: Colors.white, // set the scaffold background to white
      body: infoData.when(
          data: (data){
            print('picture : ${data.first.picture}');
            return  Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: Card(
                        elevation: 0,
                        color: Colors.grey.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.black
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: SizedBox(
                          height: 90.h,
                          width: 350.w,
                          child: ListTile(
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 0.h),
                            title: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.h, horizontal: 8.w),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30.sp,
                                    backgroundImage: NetworkImage(
                                        '${Api.basePicUrl}${data.first.picture}'),
                                  ),
                                  SizedBox(width: 15.w),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        data.first.name,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        width: 255.w,
                                        // color: Colors.red,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Number: ${data.first.mobile_no}',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 10.sp),
                                                ),

                                                Text(
                                                  'Email: ${data.first.email}',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 10.sp),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Enable tracking',
                        style: TextStyle(fontSize: 18,color: Colors.black),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          _toggleEnabled(value, data.first.id);
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeTrackColor: Colors.blue.withOpacity(0.5),
                        activeColor: primary,
                      ),
                    ],
                  ),
                  isSwitched
                      ? Container(
                    margin: EdgeInsets.only(top: 16),
                    width: double.infinity,
                    height: 70.h,
                    color: Colors.grey[300],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Latitude: ${_currentPosition?.latitude ?? 0}',style: TextStyle(color: Colors.black),),
                        SizedBox(height: 16),
                        Text('Longitude: ${_currentPosition?.longitude ?? 0}',style: TextStyle(color: Colors.black),),
                        SizedBox(height: 16),
                      ],
                    ),
                  )
                      : SizedBox(),
                ],
              ),
            );
          },
          error: (err,stack)=>Center(child:Text('$err',style: TextStyle(color:Colors.black),)),
          loading: ()=>NoticeShimmer()
      )


    );
  }
}
