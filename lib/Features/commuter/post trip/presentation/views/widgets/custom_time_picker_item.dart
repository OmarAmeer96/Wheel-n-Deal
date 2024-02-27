import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class CustomTimePickerItem extends StatefulWidget {
  const CustomTimePickerItem({
    super.key,
    required this.text,
    required this.onTimeSelected,
  });

  final String text;
  final void Function(TimeOfDay selectedTime) onTimeSelected;

  @override
  // ignore: library_private_types_in_public_api
  _CustomTimePickerItemState createState() => _CustomTimePickerItemState();
}

class _CustomTimePickerItemState extends State<CustomTimePickerItem> {
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? TimeOfDay.now(),
        );
        if (pickedTime != null) {
          setState(() {
            selectedTime = pickedTime;
          });
          widget.onTimeSelected(pickedTime);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Text(
              widget.text,
              style: Styles.cairoSemiBold.copyWith(
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Container(
              height: 30,
              width: 200,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1,
                    color: kPrimaryColor,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    selectedTime != null
                        ? _formatTime(selectedTime!)
                        : 'Select Time',
                    style: Styles.cairoSemiBold.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.access_time,
                      color: kPrimaryColor,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(TimeOfDay timeOfDay) {
    int hour = timeOfDay.hour;
    String period = 'AM';

    if (hour >= 12) {
      period = 'PM';
      if (hour > 12) {
        hour -= 12;
      }
    }

    return '${hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')} $period';
  }
}
