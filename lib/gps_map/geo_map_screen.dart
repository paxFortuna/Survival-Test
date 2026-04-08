import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GpsMapApp extends StatefulWidget {
  const GpsMapApp({super.key});

  @override
  State<GpsMapApp> createState() => GpsMapAppState();
}

class GpsMapAppState extends State<GpsMapApp> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  int _polylineIdCount = 0;
  Set<Polyline> polylines = {};
  LatLng? _prevPosition;

  CameraPosition? _initialCameraPosition;

  // static const CameraPosition _kLake = CameraPosition(
  //   bearing: 192.8334901395799,
  //   target: LatLng(37.43296265331129, -122.08832357078792),
  //   tilt: 59.440717697143555,
  //   zoom: 19.151926040649414,
  // );

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final positon = await _determinePosition();
    _initialCameraPosition = CameraPosition(
      target: LatLng(positon.latitude, positon.longitude),
      zoom: 17,
    );
    setState(() {});
    // print(positon.toString());
    const locationSettings = LocationSettings();
    Geolocator.getPositionStream(locationSettings: locationSettings).listen((
      Position position,
    ) {
      _polylineIdCount++;
      final polylineId = PolylineId('$_polylineIdCount');
      final polyline = Polyline(
        polylineId: polylineId,
        color: Colors.red,
        width: 5,
        points: [
          _prevPosition ?? _initialCameraPosition!.target,
         LatLng(positon.latitude, positon.longitude),
        ],
      );
      setState(() {
        polylines.add(polyline);
        _prevPosition = LatLng(positon.latitude, positon.longitude);
      });

      _moveCamera(position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _initialCameraPosition == null
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _initialCameraPosition!,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                polylines: polylines,
              ),
    );
  }

  Future<void> _moveCamera(Position position) async {
    final GoogleMapController controller = await _controller.future;
    final cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 17,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
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
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
