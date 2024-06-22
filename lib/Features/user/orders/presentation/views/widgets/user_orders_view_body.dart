import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheel_n_deal/Core/widgets/orders_stats_buttons.dart';
import 'package:wheel_n_deal/Features/user/orders/logic/post_order_cubit/get_user_orders_cubit.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/widgets/user_completed_orders_body.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/widgets/user_pending_orders_body.dart';
import 'package:wheel_n_deal/constants.dart';

class UserOrdersViewBody extends StatefulWidget {
  const UserOrdersViewBody({super.key});

  @override
  CommuterOrdersViewBodyState createState() => CommuterOrdersViewBodyState();
}

class CommuterOrdersViewBodyState extends State<UserOrdersViewBody> {
  bool _isPending = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        backgroundColor: const Color(0xFF1c272e),
        color: kPrimaryColor,
        displacement: 10,
        onRefresh: () async {
          _isPending
              ? context.read<GetUserOrdersCubit>().emitGetUserOrdersState()
              // TODO: Fetch the completed orders
              : null;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OrdersStatsButtons(
                isPending: _isPending,
                onPendingPressed: () {
                  setState(() {
                    _isPending = true;
                  });
                },
                onCompletedPressed: () {
                  setState(() {
                    _isPending = false;
                  });
                },
              ),
              _isPending
                  ? const UserPendingOrdersBody()
                  : const UserCompletedOrdersBody(),
            ],
          ),
        ),
      ),
    );
  }
}
