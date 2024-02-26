import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/messages/presentation/views/widgets/custom_messages_text_form_field.dart';
import 'package:wheel_n_deal/Features/commuter/messages/presentation/views/widgets/search_result_item.dart';

class UserMessagesViewBody extends StatefulWidget {
  const UserMessagesViewBody({super.key});

  @override
  State<UserMessagesViewBody> createState() => _UserMessagesViewBodyState();
}

class _UserMessagesViewBodyState extends State<UserMessagesViewBody> {
  String? search;

  final _searchController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16, right: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                CustomMessagesTextFormField(
                  borderColor: Colors.transparent,
                  fillColor: const Color(0xCCA3A3A3),
                  hintText: 'Search in messages',
                  hintStyle: Styles.manropeRegular14
                      .copyWith(fontSize: 17, color: const Color(0xff191D31)),
                  controller: _searchController,
                  onChanged: (value) {
                    search = value;
                  },
                  contentPadding: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid commuter name';
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recent",
                    style: Styles.manropeRegular16.copyWith(
                      color: const Color(0xFF191D31),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  color: Color(0xFFF3F3F3),
                  thickness: 2,
                ),
                const SizedBox(height: 17),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kUserChatView);
                  },
                  child: const SearchResultItem(
                    commuterName: 'Ahmed',
                  ),
                ),
                const SearchResultItem(
                  commuterName: 'Ali',
                ),
                const SearchResultItem(
                  commuterName: 'Mohammed',
                ),
                const SearchResultItem(
                  commuterName: 'Ahmed_1',
                ),
                const SearchResultItem(
                  commuterName: 'Ali_12',
                ),
                const SearchResultItem(
                  commuterName: 'Ahmed1',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
