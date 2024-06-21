import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  // step 1 : method to check if location service is enabled or not
  Future<void> checkAndRequestLocationService() async {
    // check if location service is enabled or not
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      // request location service
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        throw LocationServiceException();
      }
    }
  }

  // step 2 : method to check if location permission is granted or not
  Future<void> checkAndRequestLocationPermission() async {
    // check if location permission is granted or not
    var permissionStatus = await location.hasPermission();
    // check if the permission is denied forever
    if (permissionStatus == PermissionStatus.deniedForever) {
      LocationServiceException();
    }
    // check if the permission is denied
    if (permissionStatus == PermissionStatus.denied) {
      // request location permission
      permissionStatus = await location.requestPermission();
      // check if the permission is not granted
      if (permissionStatus != PermissionStatus.granted) {
        // throw an exception
        throw LocationPermissionException();
      }
    }
  }

  // notice here in this commit we don't need this method now cuz we don't want a stream of data
  void getRealTimeLocationData(void Function(LocationData)? onData) async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    location.onLocationChanged.listen(onData);
  }

  // step 3 : method to get the location data
  Future<LocationData> getLocation() async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    return await location.getLocation();
  }
}

class LocationServiceException implements Exception {}

class LocationPermissionException implements Exception {}
