import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/user/orders/data/models/get_user_orders_response.dart';
import 'package:wheel_n_deal/Features/user/orders/logic/post_order_cubit/get_user_orders_cubit.dart';
import 'package:wheel_n_deal/Features/user/orders/logic/post_order_cubit/get_user_orders_state.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/widgets/user_pending_orders_item.dart';
import 'package:wheel_n_deal/constants.dart';

class UserPendingOrdersBody extends StatefulWidget {
  const UserPendingOrdersBody({super.key});

  @override
  State<UserPendingOrdersBody> createState() => _UserPendingOrdersBodyState();
}

class _UserPendingOrdersBodyState extends State<UserPendingOrdersBody> {
  @override
  void initState() {
    context.read<GetUserOrdersCubit>().emitGetUserOrdersState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetUserOrdersCubit, GetUserOrdersState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
            );
          },
          success: (getUserOrdersResponse) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(getUserOrdersResponse.message),
                duration: const Duration(seconds: 3),
              ),
            );
            if (getUserOrdersResponse.message == "Orders found") {
              final List<GetUserOrdersResponseData> userOrders = [];
              userOrders.addAll(getUserOrdersResponse.data);
              log(userOrders.toString());
              // GoRouter.of(context).pop();
            }
            // GoRouter.of(context).pushReplacement(
            //   AppRouter.kUserOrdersView,
            // );
          },
          error: (error) {
            setupErrorState(
              context,
              error,
            );
          },
        );
      },
      child: UserOrderItem(
        userOrder: ,
      ),
    );
  }

  void setupErrorState(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          error,
          textAlign: TextAlign.center,
          style: Styles.manropeBold32.copyWith(
            color: kPrimaryColor,
            fontSize: 15,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Got it',
              style: Styles.manropeBold32.copyWith(
                color: kPrimaryColor,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserOrderItem extends StatelessWidget {
  const UserOrderItem({
    super.key,
    required this.userOrder,
  });

  final GetUserOrdersResponseData userOrder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 26,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Recent Packages",
            style: Styles.manropeSemiBold16.copyWith(fontSize: 18),
          ),
        ),
        const SizedBox(
          height: 26,
        ),
        UserPendingOrdersItem(
          onTap: () {
            GoRouter.of(context).push(AppRouter.kUserOrderDetailsView);
          },
        ),
      ],
    );
  }
}
