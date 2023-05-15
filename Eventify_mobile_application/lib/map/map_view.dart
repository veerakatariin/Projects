import 'dart:typed_data';

import 'package:eventify_frontend/apis/controllers/event_controller.dart';
import 'package:eventify_frontend/event/eventcard_view.dart';
import 'package:eventify_frontend/map/map_styles.dart';
import 'package:eventify_frontend/apis/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import 'package:location/location.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MapView extends StatefulWidget {
  const MapView();

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Set<Marker> markerlist = new Set(); //markers for google map
  _MapViewState();
  bool _filtered = true;
  late Set<Marker> markers;
  late BitmapDescriptor customIcon;
  var interestList;
  bool not_found = true;

  Location _location = Location();

  late SharedPreferences prefs;
  late bool isPlatformDark;
  retrieveTheme() async {
    prefs = await SharedPreferences.getInstance();
    interestList =
        prefs.getStringList("userInterests")?.map(int.parse).toList();
    setState(() {
      if (prefs.getString("darkMode") == "true") {
        isPlatformDark = true;
      } else {
        isPlatformDark = false;
      }
    });
  }

  @override
  void initState() {
    not_found = true;
    loadmarkers();
    retrieveTheme();
    super.initState();
  }

  var _state = 'load';
  String _filterValue = 'INTERESTS';

  void selectEvent(String id) {
    setState(() {
      _state = id;
    });
  }

// Marker icon
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  List<Marker> allMarkers = [];

  loadmarkers() async {
    // Get marker image from assets and set marker size
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/jake.png', 120);
    List<EventData> markers = [];
    allMarkers.clear();
    if (_filtered) {
      print("filtered");
      markers =
          await fetchEventsFromInterestsList(); // later interestList when its having it
    } //we store the response in a list
    else {
      print("not filtered");
      markers = await fetchAllEventsData();
    }
    // Set markers on list
    for (int i = 0; i < markers.length; i++) {
      print(markers[i].id);
      LatLng latlng = new LatLng(markers[i].latitude!, markers[i].longitude!);
      allMarkers.add(Marker(
          markerId: MarkerId(markers[i].id.toString()),
          position: latlng,
          infoWindow: InfoWindow(
            //popup info
            title: markers[i].title,
            snippet: markers[i].description + '. TAP TO SEE MORE',
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EventCardView(markers[i].id, markers[i].hostID);
            })),
          ),
          icon: BitmapDescriptor.fromBytes(markerIcon) //Icon for Marker
          ));
    }
    setState(() {
      _state = '';
    });
  }

  static const _initialCameraPosition =
      CameraPosition(target: LatLng(0, 0), zoom: 1);

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
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_state == 'load') {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          body: GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _onMapCreated(controller),
            markers: Set<Marker>.of(allMarkers),
          ),
          floatingActionButton: Card(
              color: isPlatformDark ? Colors.black : Colors.white,
              margin: EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                  child: DropdownButton<String>(
                    value: _filterValue,
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _filterValue = newValue!;
                        if (_filtered) {
                          _filtered = false;
                          print(_filtered);
                        } else {
                          _filtered = true;
                          print(_filtered);
                        }
                        loadmarkers();
                      });
                    },
                    items: <String>['ALL', 'INTERESTS']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ))));
    }
  }
}
