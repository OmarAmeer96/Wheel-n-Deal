import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:wheel_n_deal/Core/networking/google%20map%20services/location_service.dart';
import 'package:wheel_n_deal/Core/networking/google%20map%20services/map_services.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_text_form_field.dart';
import 'package:wheel_n_deal/Features/user/post_order/data/models/Google%20Map%20Models/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/google%20map%20widgets/custom_list_view.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/user_stepper_steps_item.dart';
import 'package:wheel_n_deal/constants.dart';

class UserSearchLocationViewBody extends StatefulWidget {
  const UserSearchLocationViewBody({super.key});

  @override
  State<UserSearchLocationViewBody> createState() =>
      _UserSearchLocationViewBodyState();
}

class _UserSearchLocationViewBodyState
    extends State<UserSearchLocationViewBody> {
  String? address;
  late TextEditingController addressController;
  final _form = GlobalKey<FormState>();

  late CameraPosition initialCameraPosition;
  late MapServices mapServices;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  List<PlaceAutocompleteModel> places = [];
  late Uuid uuid;
  String? sessionToken;
  Timer? debounce;

  @override
  void initState() {
    mapServices = MapServices();

    uuid = const Uuid();

    addressController = TextEditingController();
    initialCameraPosition = const CameraPosition(target: LatLng(0, 0));
    fetchPredictions();
    super.initState();
  }

  void fetchPredictions() {
    addressController.addListener(() {
      // if the debounce is active then cancel it
      if (debounce?.isActive ?? false) {
        debounce?.cancel();
      }

      // start the debounce
      debounce = Timer(const Duration(milliseconds: 100), () async {
        // if the session token is null then assign a new session token
        sessionToken ??= uuid.v4();
        await mapServices.getPredictions(
            input: addressController.text,
            sessionToken: sessionToken!,
            places: places);
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    addressController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (controller) {
                googleMapController = controller;
                updateCurrentLocation();
              },
              markers: markers,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomMainButton(
              onPressed: () async {
                final result = await showModalBottomSheet<String>(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: Responsive.screenHeight(context) * 0.7,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
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
                            const SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: SvgPicture.asset(
                                  AssetsData.locationIcon,
                                  height: 35,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Form(
                              key: _form,
                              child: StepItem(
                                widget: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Complete Address",
                                        style: Styles.manropeRegular15.copyWith(
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    CustomMainTextFormField(
                                      borderColor: Colors.transparent,
                                      fillColor: Colors.transparent,
                                      hintText: 'Add your address..',
                                      controller: addressController,
                                      onChanged: (value) {
                                        // Update the UI when the address changes
                                      },
                                      contentPadding: 7,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your address.";
                                        }
                                        return null;
                                      },
                                      focusedBorderColor:
                                          const Color(0xff55433c),
                                      enabledBorderColor: kPrimaryColor,
                                      inputType: TextInputType.text,
                                      prefixIcon: const Icon(Icons.person),
                                      obscureText: false,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            CustomListView(
                              places: places,
                              mapServices: mapServices,
                              addressController: addressController,
                              onPlaceSelect: (placeDetailsModel) async {
                                addressController.clear();
                                places.clear();
                                setState(() {});
                              },
                            ),
                            CustomMainButton(
                              text: "Confirm Location",
                              onPressed: () {
                                if (_form.currentState!.validate()) {
                                  Navigator.pop(
                                      context, addressController.text);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Please enter a valid address',
                                      ),
                                    ),
                                  );
                                }
                              },
                              color: kPrimaryColor,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    );
                  },
                );
                if (result != null) {
                  setState(() {
                    address = result;
                    addressController.text = result;
                  });
                }
              },
              color: kPrimaryColor,
              text: "Add Location",
            ),
          ),
        ],
      ),
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
