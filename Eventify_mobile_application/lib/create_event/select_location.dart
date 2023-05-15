import 'package:eventify_frontend/map/map_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLocation extends StatefulWidget {
  // ignore: use_key_in_widget_constructors

  const SelectLocation({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<SelectLocation> {
  final Set<Marker> markerlist = {}; //markers for google map
  _MapScreenState();

  bool not_found = true;

  Location _location = Location();

  var locationMarker;
  var location = 'null';
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(0, 0), zoom: 1);

  late SharedPreferences prefs;
  late bool isPlatformDark;

  retrieveTheme() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString("darkMode") == "true") {
        isPlatformDark = true;
      } else {
        isPlatformDark = false;
      }
    });
  }

  late GoogleMapController _googleMapController;
  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
    if (isPlatformDark) {
      _googleMapController.setMapStyle(map_style_dark);
    }
    if (not_found) {
      _location.onLocationChanged.listen((l) {
        _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
          ),
        );
        not_found = false;
      });
    }
  }

  @override
  void initState() {
    not_found = true;
    retrieveTheme();
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GoogleMap(
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (controller) => _onMapCreated(controller),
          markers: {if (locationMarker != null) locationMarker},
          onTap: _addMarker),
      floatingActionButton: SizedBox(
          height: 120.0,
          width: 340,
          child: Column(children: [
            FloatingActionButton(
              onPressed: () => Navigator.pop(context, location),
              child: const Text('Select'),
            ),
            Text(
              'SELECT THIS LOCATION FOR YOUR EVENT:\n' + location,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold),
            ),
          ])),
    );
  }

  void _addMarker(LatLng pos) {
    location = pos
        .toString()
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('LatLng', '');
    setState(() {
      locationMarker = Marker(
          markerId: const MarkerId('location'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos);
    });
  }
}
