import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:wheel_n_deal/Core/networking/google%20map%20services/location_service.dart';
import 'package:wheel_n_deal/Core/networking/google%20map%20services/map_services.dart';
import 'package:wheel_n_deal/Features/user/tracking/data/models/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:wheel_n_deal/Features/user/tracking/presentation/views/widgets/google%20map%20widgets/custom_list_view.dart';
import 'package:wheel_n_deal/Features/user/tracking/presentation/views/widgets/google%20map%20widgets/custom_text_field.dart';

class GoogleMapViewBody extends StatefulWidget {
  const GoogleMapViewBody({super.key});

  @override
  State<GoogleMapViewBody> createState() => _GoogleMapViewBodyState();
}

class _GoogleMapViewBodyState extends State<GoogleMapViewBody> {
  late CameraPosition initalCameraPosition;
  late MapServices mapServices;
  late TextEditingController textEditingController;

  // initialize the google map controller and make it late to initialize it later
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  List<PlaceAutocompleteModel> places = [];
  Set<Polyline> polylines = {};

  // initialize the uuid
  late Uuid uuid;
  // initialize the session token
  String? sessionToken;

  late LatLng desination;

  Timer? debounce;

  @override
  void initState() {
    mapServices = MapServices();

    // initialize the uuid
    uuid = const Uuid();

    textEditingController = TextEditingController();
    initalCameraPosition = const CameraPosition(target: LatLng(0, 0));

    fetchPredictions();
    super.initState();
  }

  void fetchPredictions() {
    textEditingController.addListener(() {
      // if the debounce is active then cancel it
      if (debounce?.isActive ?? false) {
        debounce?.cancel();
      }

      // start the debounce
      debounce = Timer(const Duration(milliseconds: 100), () async {
        // if the session token is null then assign a new session token
        sessionToken ??= uuid.v4();
        await mapServices.getPredictions(
            input: textEditingController.text,
            sessionToken: sessionToken!,
            places: places);
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          polylines: polylines,
          zoomControlsEnabled: false,
          initialCameraPosition: initalCameraPosition,
          // onMapCreated callback to get the google map controller
          onMapCreated: (controller) {
            // assign the google map controller to the googleMapController
            googleMapController = controller;
            // we have put updateCurrentLocation here to make sure that the googleMapController is initialized
            updateCurrentLocation();
          },
          markers: markers,
        ),
        Positioned(
          top: 20,
          left: 25,
          right: 25,
          child: Column(
            children: [
              CustomTextField(
                textEditingController: textEditingController,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomListView(
                places: places,
                mapServices: mapServices,
                onPlaceSelect: (placeDetailsModel) async {
                  textEditingController.clear();
                  places.clear();
                  sessionToken = null;
                  setState(() {});
                  desination = LatLng(
                      placeDetailsModel.geometry!.location!.lat!,
                      placeDetailsModel.geometry!.location!.lng!);

                  var points =
                      await mapServices.getRouteData(desination: desination);
                  mapServices.displayRoute(points,
                      polylines: polylines,
                      googleMapController: googleMapController);
                  setState(() {});
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  void updateCurrentLocation() {
    try {
      mapServices.updateCurrentLocation(
          googleMapController: googleMapController,
          markers: markers,
          onUpdateCurrentLocation: () {
            setState(() {});
          });
      setState(() {});
      // ignore: unused_catch_clause
    } on LocationServiceException catch (e) {
      // TODO: handle the exception
      // ignore: unused_catch_clause
    } on LocationPermissionException catch (e) {
      // TODO: handle the exception
    } catch (e) {
      // TODO: handle the exception
    }
  }
}
