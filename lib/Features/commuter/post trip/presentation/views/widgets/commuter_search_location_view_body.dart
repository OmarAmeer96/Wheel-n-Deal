import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_text_form_field.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/user_stepper_steps_item.dart';
import 'package:wheel_n_deal/constants.dart';

class CommuterSearchLocationViewBody extends StatefulWidget {
  const CommuterSearchLocationViewBody({super.key});

  @override
  State<CommuterSearchLocationViewBody> createState() =>
      _CommuterSearchLocationViewBodyState();
}

class _CommuterSearchLocationViewBodyState
    extends State<CommuterSearchLocationViewBody> {
  String? address;
  final _addressController = TextEditingController();
  final _form = GlobalKey<FormState>();

  late CameraPosition initialCameraPosition;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(30.79900787528476, 31.00206213176501),
      zoom: 13,
    );
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _form,
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                onMapCreated: (controller) {
                  googleMapController = controller;
                  initMapStyle();
                },
                initialCameraPosition: initialCameraPosition,
                mapType: MapType.normal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomMainButton(
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
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: Responsive.screenHeight(context) * 0.7,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                height: 5,
                              ),
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
                              const SizedBox(
                                height: 42,
                              ),
                              StepItem(
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomMainTextFormField(
                                      borderColor: Colors.transparent,
                                      fillColor: Colors.transparent,
                                      hintText: 'Input your address..',
                                      controller: _addressController,
                                      onChanged: (value) {
                                        address = value;
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
                              const Spacer(),
                              CustomMainButton(
                                text: "Confirm Location",
                                onPressed: () {
                                  context.pop();
                                },
                                color: kPrimaryColor,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                color: kPrimaryColor,
                text: "Add Location",
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/night_map_style.json');
    // ignore: deprecated_member_use
    googleMapController.setMapStyle(nightMapStyle);
  }
}
