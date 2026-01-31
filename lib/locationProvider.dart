import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends ChangeNotifier {
  StreamSubscription? _positionSubscriber;

  List<LatLng> locations = [];

  Future<void> listenCurrentLocation() async {
    checkLocationPermissionService(
      onSuccess: () {
        _positionSubscriber = Geolocator.getPositionStream().listen((
          currentLocation,
        ) {
          print("================================================");
          print(currentLocation);
          locations.add(
            LatLng(currentLocation.latitude, currentLocation.longitude),
          );
          notifyListeners();
        });
      },
    );
    notifyListeners();
  }
}

Future<void> checkLocationPermissionService({
  required VoidCallback onSuccess,
}) async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (isPermissionAllowed(permission)) {
    bool isLocationServiceEnable = await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnable) {
      onSuccess();
    } else {
      Geolocator.openLocationSettings();
    }
  } else {
    await Geolocator.requestPermission();
    LocationPermission requestPermission = await Geolocator.requestPermission();
    if (isPermissionAllowed(requestPermission)) {}
  }
}

bool isPermissionAllowed(LocationPermission permission) {
  return permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse;
}
