import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';

import 'package:wheel_n_deal/Core/utils/build_app_bar.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/user/orders/data/models/get_user_orders_response.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/widgets/user_order_details_view_body.dart';

class UserOrderDetailsView extends StatelessWidget {
  final GetUserOrdersResponseData? userOrder;
  const UserOrderDetailsView({
    super.key,
    this.userOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        text: "Order Details",
        textStyle: Styles.manropeSemiBold16.copyWith(
          fontSize: 18,
        ),
        onPressed: () {
          context.pop();
        },
      ),
      body: UserOrderDetailsViewBody(userOrder: userOrder),
    );
  }
}
