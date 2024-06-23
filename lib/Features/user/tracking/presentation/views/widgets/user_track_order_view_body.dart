import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';
import 'package:wheel_n_deal/Core/routing/routes.dart';

import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/constants.dart';

class UserTrackOrderViewBody extends StatefulWidget {
  const UserTrackOrderViewBody({super.key});

  @override
  State<UserTrackOrderViewBody> createState() => _UserTrackOrderViewBodyState();
}

class _UserTrackOrderViewBodyState extends State<UserTrackOrderViewBody> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation =
      LatLng(30.715955406355206, 31.24852084527862);
  //static const LatLng midLocation =LatLng(30.79900787528476, 31.00206213176501);
  static const LatLng destinationLocation =
      LatLng(30.786541739058805, 31.000364821862284);
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      currentLocation = location;
    });

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen(
      (newLocation) {
        currentLocation = newLocation;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(newLocation.latitude!, newLocation.longitude!),
              zoom: 11.5,
            ),
          ),
        );
        setState(() {});
      },
    );
  }

  void getPolyPoints() async {
    PolylinePoints polyLinePoints = PolylinePoints();
    PolylineResult result = await polyLinePoints.getRouteBetweenCoordinates(
      "AIzaSyD-8J9J0Q2J9Q2J9J9Q2J9J9Q2J9J9Q2J9",
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
        setState(() {});
      }
    }
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      AssetsData.sourceMarker,
    ).then((icon) {
      sourceIcon = icon;
    });
    BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      AssetsData.destinationMarker,
    ).then((icon) {
      destinationIcon = icon;
    });
    BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      AssetsData.currentMarker,
    ).then((icon) {
      currentLocationIcon = icon;
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    setCustomMarkerIcon();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Picking up your order",
                style: Styles.manropeExtraBold18.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: currentLocation == null
                  ? const Text("Loading...")
                  : GoogleMap(
                      onMapCreated: (mapController) {
                        _controller.complete(mapController);
                        // initMapStyle();
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(currentLocation!.latitude!,
                            currentLocation!.longitude!),
                        zoom: 11.5,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId("currentLocation"),
                          icon: currentLocationIcon,
                          position: LatLng(currentLocation!.latitude!,
                              currentLocation!.longitude!),
                        ),
                        Marker(
                          markerId: const MarkerId("source"),
                          icon: sourceIcon,
                          position: sourceLocation,
                        ),
                        Marker(
                          markerId: const MarkerId("destination"),
                          icon: destinationIcon,
                          position: destinationLocation,
                        ),
                      },
                      polylines: {
                        Polyline(
                          polylineId: const PolylineId("route"),
                          color: kPrimaryColor,
                          points: polylineCoordinates,
                          width: 5,
                        ),
                      },
                      mapType: MapType.normal,
                    ),
            ),
            const SizedBox(
              height: 12,
            ),
            CustomMainButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 60,
                              height: 6,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFA3A3A3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                SizedBox(
                                  height: 64,
                                  child: Image.asset(
                                    AssetsData.profileImage,
                                  ),
                                ),
                                Positioned(
                                  bottom: -10,
                                  left: -1,
                                  right: -1,
                                  child: Card(
                                    elevation:
                                        8.0, // Adjust the elevation value as needed
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "4.5",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Spacer(),
                                          SvgPicture.asset(
                                            AssetsData.starIcon,
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Ahmed is taking care of your order today",
                              style: Styles.manropeExtraBold18.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            InkWell(
                              onTap: () {
                                context.pushNamed(Routes
                                    .kCommuterProfileSeenByUserFromTrackingView);
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  "View profile",
                                  style: Styles.manropeExtraBold18.copyWith(
                                    fontSize: 16,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              text: "Chat",
              color: kPrimaryColor,
              height: 45,
            ),
          ],
        ),
      ),
    );
  }

  // void initMapStyle() async {
  //   var nightMapStyle = await DefaultAssetBundle.of(context)
  //       .loadString('assets/map_styles/night_map_style.json');
  //   // ignore: deprecated_member_use
  //   googleMapController.setMapStyle(nightMapStyle);
  // }
}
