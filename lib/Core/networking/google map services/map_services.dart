import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wheel_n_deal/Core/networking/google%20map%20services/google_maps_place_service.dart';
import 'package:wheel_n_deal/Core/networking/google%20map%20services/location_service.dart';
import 'package:wheel_n_deal/Core/networking/google%20map%20services/routes_service.dart';
import 'package:wheel_n_deal/Features/user/post_order/data/models/Google%20Map%20Models/location_info/lat_lng.dart';
import 'package:wheel_n_deal/Features/user/post_order/data/models/Google%20Map%20Models/location_info/location.dart';
import 'package:wheel_n_deal/Features/user/post_order/data/models/Google%20Map%20Models/location_info/location_info.dart';
import 'package:wheel_n_deal/Features/user/post_order/data/models/Google%20Map%20Models/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:wheel_n_deal/Features/user/post_order/data/models/Google%20Map%20Models/place_details_model/place_details_model.dart';
import 'package:wheel_n_deal/Features/user/post_order/data/models/Google%20Map%20Models/routes_model/routes_model.dart';

class MapServices {
  PlacesService placesService = PlacesService();
  LocationService locationService = LocationService();
  RoutesService routesService = RoutesService();
  LatLng? currentLocation;

  Future<void> getPredictions(
      {required String input,
      required String sessionToken,
      required List<PlaceAutocompleteModel> places}) async {
    // if the text field is not empty then make a request to the google maps places service
    if (input.isNotEmpty) {
      var result = await placesService.getPredictions(
          sessionToken: sessionToken, input: input);
      places.clear();
      places.addAll(result);
    } else {
      places.clear();
    }
  }

  Future<List<LatLng>> getRouteData({required LatLng desination}) async {
    // create a new LocationInfoModel object with the current location
    LocationInfoModel origin = LocationInfoModel(
      location: LocationModel(
        latLng: LatLngModel(
          latitude: currentLocation!.latitude,
          longitude: currentLocation!.longitude,
        ),
      ),
    );

    // create a new LocationInfoModel object with the destination location
    LocationInfoModel destination = LocationInfoModel(
      location: LocationModel(
          latLng: LatLngModel(
        latitude: desination.latitude,
        longitude: desination.longitude,
      )),
    );

    RoutesModel routes = await routesService.fetchRoutes(
        origin: origin, destination: destination);

    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> points = getDecodedRoute(polylinePoints, routes);

    return points;
  }

  List<LatLng> getDecodedRoute(
      PolylinePoints polylinePoints, RoutesModel routes) {
    List<PointLatLng> result = polylinePoints.decodePolyline(
      routes.routes!.first.polyline!.encodedPolyline!,
    );

    List<LatLng> points =
        result.map((e) => LatLng(e.latitude, e.longitude)).toList();

    return points;
  }

  void displayRoute(List<LatLng> points,
      {required Set<Polyline> polylines,
      required GoogleMapController googleMapController}) {
    Polyline route = Polyline(
      color: Colors.blue,
      width: 5,
      polylineId: const PolylineId('route'),
      points: points,
    );
    polylines.add(route);
    LatLngBounds bounds = getLatLngBounds(points);
    getLatLngBounds(points);
    googleMapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 30));
  }

  LatLngBounds getLatLngBounds(List<LatLng> points) {
    var southWestLatitude = points.first.latitude;
    var southWestLongitude = points.first.longitude;
    var northEastLatitude = points.first.latitude;
    var northEastLongitude = points.first.longitude;

    for (var point in points) {
      southWestLatitude = min(southWestLatitude, point.latitude);
      southWestLongitude = min(southWestLongitude, point.longitude);
      northEastLatitude = max(northEastLatitude, point.latitude);
      northEastLongitude = max(northEastLongitude, point.longitude);
    }
    return LatLngBounds(
        southwest: LatLng(southWestLatitude, southWestLongitude),
        northeast: LatLng(northEastLatitude, northEastLongitude));
  }

  void updateCurrentLocation(
      {required GoogleMapController googleMapController,
      required Set<Marker> markers,
      required Function onUpdateCurrentLocation}) {
    // get the location data
    locationService.getRealTimeLocationData((locationData) {
      // create a new LatLng object with the location data
      currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
      Marker currentLocationMarker = Marker(
        markerId: const MarkerId('my location'),
        position: currentLocation!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
      // update the camera position
      CameraPosition myCameraPosition =
          CameraPosition(target: currentLocation!, zoom: 16.5);
      // animate the camera to the new position
      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(myCameraPosition));
      // add the marker to the markers set
      markers.add(currentLocationMarker);
      onUpdateCurrentLocation();
    });
  }

  Future<PlaceDetailsModel> getPlaceDetails({required String placeId}) async {
    return await placesService.getPlaceDetails(placeId: placeId);
  }
}
