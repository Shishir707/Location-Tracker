import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    late final GoogleMapController _mapController;
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
          _mapController = controller;
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
          Marker(
            markerId: MarkerId('location-dragger'),
            position: LatLng(23.815347178121932, 90.4081017896533),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
            draggable: true,
            onDragStart: (LatLng latLng) {
              print("Drag start from $latLng");
            },
            onDragEnd: (LatLng latLng) {
              print('Drag end point is $latLng');
            },
          ),
        },
        polylines: <Polyline>{
          Polyline(
            polylineId: PolylineId('my-route'),
            points: [
              LatLng(23.815583971830566, 90.41056003421545),
              LatLng(23.816479919246486, 90.41013825684786),
              LatLng(23.817555293360872, 90.41006147861481),
              LatLng(23.817600074862085, 90.41079070419073),
            ],
            color: Colors.blue,
            width: 8,
            visible: true,
            startCap: Cap.buttCap,
            endCap: Cap.roundCap,
            onTap: () {
              print("Click on Polyline");
            },
          ),
        },
        circles: <Circle>{
          Circle(
            circleId: CircleId("newLand-circle"),
            center: LatLng(23.817600074862085, 90.41079070419073),
            radius: 50,
            fillColor: Colors.blue.withAlpha(100),
            strokeColor: Colors.blue,
            strokeWidth: 2,
          ),
          Circle(
            circleId: CircleId("home-circle"),
            center: LatLng(23.815583971830566, 90.41056003421545),
            radius: 30,
            fillColor: Colors.green.withAlpha(100),
            strokeColor: Colors.green,
            strokeWidth: 2,
          ),
        },
        polygons: <Polygon>{
          Polygon(
            polygonId: PolygonId('Dangerous-Area'),
            points: [
              LatLng(23.81653206252087, 90.4090291634202),
              LatLng(23.816498322757486, 90.40958236902952),
              LatLng(23.816069213547184, 90.409398637712),
              LatLng(23.81607780187982, 90.40889874100685),
              LatLng(23.816548932399282, 90.40881592780352),
            ],
            fillColor: Colors.red.withAlpha(100),
            strokeColor: Colors.red,
            strokeWidth: 2,
            onTap: () {
              print('This is a dangerous area.Maintain distance');
            },
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mapController.animateCamera( //Also use moveCamera
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 16,
                target: LatLng(23.815583971830566, 90.41056003421545),
              ),
            ),
          );
        },
        child: Icon(Icons.home),
      ),
    );
  }
}
