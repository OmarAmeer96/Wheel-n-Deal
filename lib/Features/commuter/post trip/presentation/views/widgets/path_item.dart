import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Features/commuter/post%20trip/presentation/views/widgets/list_of_paths_text_field.dart';

class PathItem extends StatelessWidget {
  const PathItem({
    super.key,
    required TextEditingController locationController,
    required this.hintText,
    required this.enabled,
    required this.validator,
    required this.inputType,
    required this.onChanged,
  }) : _locationController = locationController;

  final TextEditingController _locationController;
  final String hintText;
  final bool enabled;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: const Color(0xff1d272f),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                AssetsData.locationIcon,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ListOfPathsTextField(
              hintText: hintText,
              controller: _locationController,
              enabled: enabled,
              validator: validator,
              onChanged: onChanged,
              inputType: inputType,
            ),
          ),
        ),
      ],
    );
  }
}
