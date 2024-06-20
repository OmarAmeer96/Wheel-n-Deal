import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router_old.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_text_form_field.dart';
import 'package:wheel_n_deal/Features/user/search_for_commuter/presentation/views/widgets/found_commuter_item.dart';

class UserSearchForCommuterViewBody extends StatefulWidget {
  const UserSearchForCommuterViewBody({super.key});

  @override
  State<UserSearchForCommuterViewBody> createState() =>
      _UserSearchForCommuterViewBodyState();
}

class _UserSearchForCommuterViewBodyState
    extends State<UserSearchForCommuterViewBody> {
  String? from;

  String? to;

  final _fromController = TextEditingController();

  final _toController = TextEditingController();

  final _form = GlobalKey<FormState>();

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
              top: 16,
              left: 16,
              right: 16,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Search',
                      style: Styles.manropeSemiBold16.copyWith(
                        fontSize: 18,
                      ),
                    ),
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
                  fillColor: const Color(0xffe4e4e4),
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
                  enabledBorderColor: const Color(0xffe4e4e4),
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
                  fillColor: const Color(0xffe4e4e4),
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
                  enabledBorderColor: const Color(0xffe4e4e4),
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
                FoundCommuterItem(
                  name: "Omar Ameer",
                  phoneNumber: "+20 1554111002",
                  from: "Tanta",
                  to: "Alex",
                  onPressed: () {
                    GoRouter.of(context)
                        .push(AppRouter.kCommuterProfileSeenByTheUserView);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                FoundCommuterItem(
                  name: "Omar Ameer",
                  phoneNumber: "+20 1554111002",
                  from: "Tanta",
                  to: "Alex",
                  onPressed: () {
                    GoRouter.of(context)
                        .push(AppRouter.kCommuterProfileSeenByTheUserView);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
