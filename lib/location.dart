import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({super.key});

  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  Position? _currentPosition;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GeoLocator",
          style: TextTheme.of(
            context,
          ).titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("My Location : ${_currentPosition}"),
            TextButton(
              onPressed: _onTapGeoLocator,
              child: Text("Get My Location"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapGeoLocator() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (isPermissionAllowed(permission)) {
      bool isLocationServiceEnable =
          await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnable) {
        Position position = await Geolocator.getCurrentPosition();
        print(position);
        setState(() {
          _currentPosition = position;
        });
      } else {
        Geolocator.openLocationSettings();
      }
    } else {
      await Geolocator.requestPermission();
      LocationPermission requestPermission =
          await Geolocator.requestPermission();
      if (isPermissionAllowed(requestPermission)) {
        _onTapGeoLocator();
      }
    }
  }

  bool isPermissionAllowed(LocationPermission permission) {
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }
}
