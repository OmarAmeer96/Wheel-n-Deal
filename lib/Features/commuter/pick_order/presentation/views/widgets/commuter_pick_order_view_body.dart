import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router_old.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_text_form_field.dart';
import 'package:wheel_n_deal/Features/user/profile/presentation/views/widgets/edit_profile_button.dart';

class CommuterPickOrderViewBody extends StatefulWidget {
  const CommuterPickOrderViewBody({
    super.key,
    required this.isAppBarIconNotHidden,
    this.onTap,
  });

  final bool isAppBarIconNotHidden;
  final void Function()? onTap;

  @override
  State<CommuterPickOrderViewBody> createState() =>
      _CommuterPickOrderViewBodyState();
}

class _CommuterPickOrderViewBodyState extends State<CommuterPickOrderViewBody> {
  String? from;

  String? to;

  final _fromController = TextEditingController();

  final _toController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pick Order',
                        style: Styles.manropeSemiBold16.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  widget.isAppBarIconNotHidden
                      ? Positioned(
                          left: 0,
                          top: 0,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(500),
                            onTap: widget.onTap,
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.arrow_back_ios_rounded),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "From",
                  style: Styles.manropeRegular15.copyWith(
                    fontSize: 18,
                    letterSpacing: -0.4,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomMainTextFormField(
                borderColor: Colors.transparent,
                fillColor: const Color(0xCCA3A3A3),
                hintText: 'Enter Location..',
                controller: _fromController,
                onChanged: (value) {
                  from = value;
                },
                contentPadding: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username.';
                  }
                  return null;
                },
                focusedBorderColor: const Color(0xff55433c),
                enabledBorderColor: const Color(0xFFA3A3A3),
                inputType: TextInputType.text,
                prefixIcon: SvgPicture.asset(
                  AssetsData.searchIcon,
                  color: Colors.black,
                ),
                suffixIcon: SvgPicture.asset(
                  AssetsData.emptyTextFieldIcon,
                ),
                suffixIconOnTap: () {},
                obscureText: false,
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "To",
                  style: Styles.manropeRegular15.copyWith(
                    fontSize: 18,
                    letterSpacing: -0.4,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomMainTextFormField(
                borderColor: Colors.transparent,
                fillColor: const Color(0xCCA3A3A3),
                hintText: 'Enter Location..',
                controller: _toController,
                onChanged: (value) {
                  to = value;
                },
                contentPadding: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username.';
                  }
                  return null;
                },
                focusedBorderColor: const Color(0xff55433c),
                enabledBorderColor: const Color(0xCCA3A3A3),
                inputType: TextInputType.text,
                prefixIcon: SvgPicture.asset(
                  AssetsData.searchIcon,
                  color: Colors.black,
                ),
                suffixIcon: SvgPicture.asset(
                  AssetsData.emptyTextFieldIcon,
                ),
                suffixIconOnTap: () {},
                obscureText: false,
              ),
              const SizedBox(
                height: 18,
              ),
              const Divider(
                color: Color(0xFFF3F3F3),
                thickness: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    AssetsData.ordersIcon,
                    // ignore: deprecated_member_use
                    color: Colors.black,
                    width: 24,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Order name",
                    style: Styles.manropeRegular15.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  EditProfileButton(
                    text: "View Details",
                    onPressed: () {
                      GoRouter.of(context)
                          .push(AppRouter.kCommuterPickOrderDetailsView);
                    },
                    color: const Color(0x4CA3A3A3),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
