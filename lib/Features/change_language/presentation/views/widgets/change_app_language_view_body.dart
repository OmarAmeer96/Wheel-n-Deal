import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class ChangeAppLanguageViewBody extends StatefulWidget {
  const ChangeAppLanguageViewBody({super.key});

  @override
  State<ChangeAppLanguageViewBody> createState() =>
      _ChangeAppLanguageViewBodyState();
}

class _ChangeAppLanguageViewBodyState extends State<ChangeAppLanguageViewBody> {
  final _form = GlobalKey<FormState>();

  String? selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select Language',
                    style: Styles.manropeBold32.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(
                          focusColor: const Color(0xff99A0A8),
                          fillColor: const WidgetStatePropertyAll(
                            kPrimaryColor,
                          ),
                          value: 'English',
                          groupValue: selectedLanguage,
                          onChanged: (value) {
                            setState(() {
                              selectedLanguage = value;
                            });
                          },
                        ),
                        Text(
                          'English',
                          style:
                              Styles.poppinsSemiBold16.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          focusColor: const Color(0xff99A0A8),
                          fillColor: const WidgetStatePropertyAll(
                            kPrimaryColor,
                          ),
                          value: 'Arabic',
                          groupValue: selectedLanguage,
                          onChanged: (value) {
                            setState(() {
                              selectedLanguage = value;
                            });
                          },
                        ),
                        Text(
                          'Arabic',
                          style:
                              Styles.poppinsSemiBold16.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
