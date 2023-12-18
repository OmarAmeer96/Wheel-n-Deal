import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../Core/utils/assets.dart';
import '../../../../../Core/utils/is_valid_fullname.dart';
import '../../../../../Core/utils/styles.dart';
import '../../../../../Core/widgets/custom_main_text_field.dart';

class UserEditProfileViewBody extends StatefulWidget {
  const UserEditProfileViewBody({super.key});

  @override
  State<UserEditProfileViewBody> createState() =>
      _UserEditProfileViewBodyState();
}

class _UserEditProfileViewBodyState extends State<UserEditProfileViewBody> {
  String? fullName;
  String? phoneNumber;
  String? gender;
  String? city;
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _genderController = TextEditingController();
  final _cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 34.0, left: 16, right: 16),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      const Positioned(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(AssetsData.profileImage),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: -25,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x59FF981A),
                                blurRadius: 8,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 27,
                            backgroundColor: Colors.white,
                            child: RawMaterialButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return const SizedBox(
                                      width: double.infinity,
                                      height: 300,
                                    );
                                  },
                                );
                              },
                              elevation: 2.0,
                              fillColor: const Color(0xFF191D31),
                              padding: const EdgeInsets.all(15.0),
                              shape: const CircleBorder(),
                              child: SvgPicture.asset(AssetsData.cameraIcon),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Full Name',
                  style: Styles.manropeExtraBold32.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomMainTextField(
                onChanged: (data) {
                  fullName = data;
                },
                controller: _fullNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name.';
                  } else if (!isValidFullName(value)) {
                    return 'Please enter a valid name.';
                  }
                  return null;
                },
                hintText: 'Input full name',
                borderColor: const Color(0xFFA3A3A3),
                focusedBorderColor: const Color(0xff55433c),
                enabledBorderColor: const Color(0xFFA3A3A3),
                inputType: TextInputType.text,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: SvgPicture.asset(AssetsData.userName),
                ),
                obscureText: false,
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Phone number',
                  style: Styles.manropeExtraBold32.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomMainTextField(
                onChanged: (data) {
                  phoneNumber = data;
                },
                controller: _phoneNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password.';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long.';
                  }
                  return null;
                },
                hintText: '01222990387',
                borderColor: const Color(0xFFA3A3A3),
                focusedBorderColor: const Color(0xff55433c),
                enabledBorderColor: const Color(0xFFA3A3A3),
                inputType: TextInputType.text,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: SvgPicture.asset(AssetsData.phoneIcon),
                ),
                obscureText: false,
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Gender',
                  style: Styles.manropeExtraBold32.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomMainTextField(
                onChanged: (data) {
                  gender = data;
                },
                controller: _genderController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name.';
                  } else if (!isValidFullName(value)) {
                    return 'Please enter a valid name.';
                  }
                  return null;
                },
                hintText: 'male/female',
                borderColor: const Color(0xFFA3A3A3),
                focusedBorderColor: const Color(0xff55433c),
                enabledBorderColor: const Color(0xFFA3A3A3),
                inputType: TextInputType.text,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: SvgPicture.asset(AssetsData.genderSvg),
                ),
                obscureText: false,
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'City',
                  style: Styles.manropeExtraBold32.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomMainTextField(
                onChanged: (data) {
                  city = data;
                },
                controller: _cityController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name.';
                  } else if (!isValidFullName(value)) {
                    return 'Please enter a valid name.';
                  }
                  return null;
                },
                hintText: 'Alex',
                borderColor: const Color(0xFFA3A3A3),
                focusedBorderColor: const Color(0xff55433c),
                enabledBorderColor: const Color(0xFFA3A3A3),
                inputType: TextInputType.text,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: SvgPicture.asset(AssetsData.citySvg),
                ),
                obscureText: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
