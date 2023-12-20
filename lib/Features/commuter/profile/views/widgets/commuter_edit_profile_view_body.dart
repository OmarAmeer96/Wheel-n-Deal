import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/constants.dart';
import '../../../../../Core/utils/assets.dart';
import '../../../../../Core/utils/styles.dart';
import '../../../../../Core/widgets/custom_main_text_field.dart';

class CommuterEditProfileViewBody extends StatefulWidget {
  const CommuterEditProfileViewBody({super.key});

  @override
  State<CommuterEditProfileViewBody> createState() =>
      _CommuterEditProfileViewBodyState();
}

class _CommuterEditProfileViewBodyState
    extends State<CommuterEditProfileViewBody> {
  String? fullName;
  String? phoneNumber;
  String? gender;
  String? city;

  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _cityController = TextEditingController();

  final _form = GlobalKey<FormState>();

  String? selectedGender;

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
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
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
                                  backgroundImage:
                                      AssetImage(AssetsData.profileImage),
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
                                      child: SvgPicture.asset(
                                          AssetsData.cameraIcon),
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
                            return 'Please enter a valid phone number.';
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
                          phoneNumber = data;
                        },
                        controller: _phoneNumberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid phone number.';
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
                          'National ID',
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
                            return 'Please enter a valid phone number.';
                          }
                          return null;
                        },
                        hintText: 'xxxxxxxxxxxxx',
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
                      Row(
                        children: [
                          SvgPicture.asset(
                            AssetsData.genderSvg,
                            width: 22,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    focusColor: const Color(0xff99A0A8),
                                    fillColor: const MaterialStatePropertyAll(
                                      kPrimaryColor,
                                    ),
                                    value: 'Male',
                                    groupValue: selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGender = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Male',
                                    style: Styles.poppinsSemiBold16
                                        .copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    focusColor: const Color(0xff99A0A8),
                                    fillColor: const MaterialStatePropertyAll(
                                      kPrimaryColor,
                                    ),
                                    value: 'Female',
                                    groupValue: selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGender = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Female',
                                    style: Styles.poppinsSemiBold16
                                        .copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomMainButton(
                        text: "Save Changes",
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            GoRouter.of(context).pop();
                          }
                        },
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
