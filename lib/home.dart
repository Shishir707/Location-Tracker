import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatelessWidget {
  late final GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Real Time Location Tracker",
          style: TextTheme.of(context).titleLarge,
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(23.815891962604944, 90.4104456016626),
          zoom: 16,
        ),
        onMapCreated: (GoogleMapController controller) {
          controller = _mapController;
        },
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        mapType: MapType.normal,
        trafficEnabled: true,
        onTap: (LatLng latLng) {
          //print(latLng);
        },
        onLongPress: (LatLng latLng) {
          //print("Long Press on $latLng");
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
