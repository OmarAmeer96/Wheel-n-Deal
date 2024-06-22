import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';
import 'package:wheel_n_deal/Core/networking/google%20map%20services/map_services.dart';
import 'package:wheel_n_deal/Core/routing/routes.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Features/user/post_order/data/models/Google%20Map%20Models/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/user_stepper_steps_item.dart';

import '../../../../../../Core/utils/styles.dart';
import '../../../../../../Core/widgets/custom_main_button.dart';
import '../../../../../../Core/widgets/custom_main_text_form_field.dart';
import '../../../../../../constants.dart';
import 'google map widgets/custom_list_view.dart';

class AddressBottomSheet extends StatefulWidget {
  final TextEditingController addressController;
  final GlobalKey<FormState> formKey;
  final List<PlaceAutocompleteModel> places;
  final MapServices mapServices;

  const AddressBottomSheet({
    required this.addressController,
    required this.formKey,
    required this.places,
    required this.mapServices,
    super.key,
  });

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.topLeft,
            child: SvgPicture.asset(
              AssetsData.locationIcon,
              height: 35,
            ),
          ),
        ),
        const SizedBox(height: 42),
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
              const SizedBox(height: 10),
              CustomMainTextFormField(
                borderColor: Colors.transparent,
                fillColor: Colors.transparent,
                hintText: 'Add your address..',
                controller: widget.addressController,
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
                focusedBorderColor: const Color(0xff55433c),
                enabledBorderColor: kPrimaryColor,
                inputType: TextInputType.text,
                prefixIcon: const Icon(Icons.person),
                obscureText: false,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        CustomListView(
          places: widget.places,
          mapServices: widget.mapServices,
          addressController: widget.addressController,
          onPlaceSelect: (placeDetailsModel) async {
            widget.addressController.clear();
            widget.places.clear();
            setState(() {});
          },
        ),
        CustomMainButton(
          text: "Confirm Location",
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              context.pushNamed(Routes.kUserPostOrderView);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter a valid address')),
              );
            }
          },
          color: kPrimaryColor,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
