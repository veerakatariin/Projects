import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventLocation extends StatefulWidget {
  // ignore: use_key_in_widget_constructors

  final double latitude;
  final double longitude;
  const EventLocation(this.latitude, this.longitude);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<EventLocation> {
  _MapScreenState();

  late GoogleMapController _googleMapController;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GoogleMap(
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude), zoom: 11.5),
      onMapCreated: (controller) => _googleMapController = controller,
      markers: {
        Marker(
          position:
              LatLng(widget.latitude, widget.longitude), //position of marke
          icon: BitmapDescriptor.defaultMarker,
          markerId: const MarkerId('event_id'), //Icon for Marker
        )
      },
    ));
  }
}
