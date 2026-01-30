import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyLocation extends StatelessWidget {
  const MyLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final Geolocator _geoLocator = Geolocator();

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
            Text("My Location"),
            TextButton(
              onPressed: _onTapGeoLocator,
              child: Text("Get My Location"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _onTapGeoLocator() async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (isPermissionAllowed(permission)) {
    bool isLocationServiceEnable = await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnable) {
      Position position = await Geolocator.getCurrentPosition();
      print(position);
    } else {
      Geolocator.openLocationSettings();
    }
  } else {
    Geolocator.requestPermission();
    LocationPermission requestPermission = await Geolocator.requestPermission();
    if (isPermissionAllowed(requestPermission)) {
      _onTapGeoLocator();
      return;
    }
  }
}

bool isPermissionAllowed(LocationPermission permission) {
  return permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse;
}
