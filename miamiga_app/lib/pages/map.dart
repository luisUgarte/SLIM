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


  Future<Position> _requestLocationPermission() async {
    bool serviceEnabled;

    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled) {
      return Future.error('Los servicios de ubicacion estan deshabilitados.');
    }

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if(permission == LocationPermission.denied) {
        return Future.error('Los permisos de ubicacion estan denegados.');
      }
    }

    if(permission == LocationPermission.deniedForever) {
      return Future.error('Los permisos de ubicacion estan denegados para siempre.');
    }
    Position position = await Geolocator.getCurrentPosition();

    return position;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),

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
    );
  }
}
