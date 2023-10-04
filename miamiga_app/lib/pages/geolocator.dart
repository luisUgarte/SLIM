import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GeolocatorScreen extends StatefulWidget {
  const GeolocatorScreen({super.key});

  @override
  State<GeolocatorScreen> createState() => _GeolocatorScreenState();
}

class _GeolocatorScreenState extends State<GeolocatorScreen> {


  /*GEOLOCOLIZADOR MAPAS*/
  String locationMsg = 'Get Location of User';
  late String lat;
  late String long;

  Future<Position> _getCurrentLocation() async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location permissions are denied');
      }
    }

    if(permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  //actualizar ubicacion
  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
      .listen((Position position) {
        lat = position.latitude.toString();
        long = position.longitude.toString();
        setState(() {
          locationMsg = 'Latitud: $lat, Longitud: $long';
        });
      });
    }

    Future<void> _openMap(String lat, String long) async {
      String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
      await canLaunchUrlString(googleUrl)
        ? await launchUrlString(googleUrl)
        : throw 'Could not launch $googleUrl';
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(locationMsg, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  _getCurrentLocation().then((value) {
                    lat = '${value.latitude}';
                    long = '${value.longitude}';
                    setState(() {
                      locationMsg = 'Latitud: $lat, Longitud: $long';
                    });
                    _liveLocation();
                  });
                },
                child: const Text('Seleccionar Ubicacion'),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  _openMap(lat, long);
                }, 
                child: const Text('Ver Mapa'),
            ),
          ],
        ),
      )
    );
  }
}