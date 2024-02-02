import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/change_language/presentation/views/widgets/change_app_language_view_body.dart';

class ChangeAppLanguageView extends StatelessWidget {
  const ChangeAppLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        text: "App Language",
        textStyle: Styles.manropeRegular16.copyWith(
          fontSize: 18,
        ),
        onPressed: () {
          GoRouter.of(context).pop();
        },
      ),
      body: const ChangeAppLanguageViewBody(),
    );
  }
}
