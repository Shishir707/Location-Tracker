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
          print(latLng);
        },
        onLongPress: (LatLng latLng) {
          print("Long Press on $latLng");
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: <Marker>{
          Marker(
            markerId: MarkerId('my-home'),
            position: LatLng(23.815583971830566, 90.41056003421545),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRose,
            ),
            visible: true,
            infoWindow: InfoWindow(
              title: "My Home",
              snippet: "Where i live",
              onTap: () {
                print("My home info window tapped");
              },
            ),
          ),
          Marker(
            markerId: MarkerId('my-office'),
            position: LatLng(23.816479919246486, 90.41013825684786),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
            visible: true,
            infoWindow: InfoWindow(
              title: "My Office",
              snippet: "Where i work",
              onTap: () {
                print("My office info window tapped");
              },
            ),
          ),
        },
        polylines: <Polyline>{
          Polyline(
            polylineId: PolylineId('my-route'),
            points: [
              LatLng(23.815583971830566, 90.41056003421545),
              LatLng(23.816479919246486, 90.41013825684786),
              LatLng(23.817555293360872, 90.41006147861481),
              LatLng(23.815986090727016, 90.40961857885122)
            ],
            color: Colors.blue,
            width: 8,
            visible: true,
            startCap: Cap.buttCap,
            endCap: Cap.roundCap,
            onTap: (){
              print("Click on Polyline");
            }

          ),
        },
      ),
    );
  }
}
