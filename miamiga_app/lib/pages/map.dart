// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({super.key});

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {

  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  Set<Marker> markers = {};

<<<<<<< HEAD
  Marker _currentLocationMarker = const Marker(
    markerId: MarkerId('current-location'),
    position: LatLng(37.42796133580664, -122.085749655962),
  );

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  Future<void> _initMap() async {
    await _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
=======

  Future<Position> _requestLocationPermission() async {
>>>>>>> origin/johan
    bool serviceEnabled;

    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled) {
<<<<<<< HEAD
      throw Exception('Location services are disabled.');
=======
      return Future.error('Los servicios de ubicacion estan deshabilitados.');
>>>>>>> origin/johan
    }

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if(permission == LocationPermission.denied) {
<<<<<<< HEAD
        throw Exception('Location permissions are denied');
=======
        return Future.error('Los permisos de ubicacion estan denegados.');
>>>>>>> origin/johan
      }
    }

    if(permission == LocationPermission.deniedForever) {
<<<<<<< HEAD
      throw Exception('Location permissions are permanently denied, we cannot request permissions.');
    }
    _updateCurrentLocationMarker();
  }

  Future<void> _updateCurrentLocationMarker() async {
    try {
      Position position = await Geolocator.getCurrentPosition();

      setState(() {
        _currentLocationMarker = Marker(
          markerId: const MarkerId('current-location'),
          position: LatLng(position.latitude, position.longitude),
        );
      });

      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 14,
          ),
        ),
      );
    }catch(e) {
      print('Error: ${e.toString()}');
    }
  }
=======
      return Future.error('Los permisos de ubicacion estan denegados para siempre.');
    }
    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

>>>>>>> origin/johan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
<<<<<<< HEAD
        markers: Set.of([_currentLocationMarker]),
=======
        markers: markers,
>>>>>>> origin/johan
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
<<<<<<< HEAD
=======

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _requestLocationPermission();
          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 14,
              ),
            ),
          );
          markers.clear();

          markers.add(
            Marker(
              markerId: const MarkerId('currentLocation'), 
              position: LatLng(
                position.latitude, 
                position.longitude
                ),
              ),
            );

          setState(() {});
        },
        label: const Text('Ubicacion actual'),
        icon: const Icon(Icons.location_history),
      )
>>>>>>> origin/johan
    );
  }
}
