import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router_old.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
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
    return Column(
      children: [
        Column(
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
          ],
        ),
        BlocBuilder<GetUserOrdersCubit, GetUserOrdersState>(
          builder: (context, state) {
            if (state is UserOrdersLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              );
            } else if (state is UserOrdersFetched) {
              return SizedBox(
                height: Responsive.screenHeight(context) * 0.7,
                child: ListView.builder(
                  itemCount: state.data.data.length,
                  itemBuilder: (context, index) {
                    final userOrder = (state).data.data[index];
                    return UserPendingOrdersItem(
                      onTap: () {
                        GoRouter.of(context)
                            .push(AppRouter.kUserOrderDetailsView);
                        // context.pushNamed(
                        //           AppRouter.kUserOrderDetailsView,
                        //           arguments: product,
                        //         );
                      },
                      userOrder: userOrder,
                    );
                  },
                ),
              );
            } else if (state is UserOrdersError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setupErrorState(context, state.error);
              });
            }
            return const SizedBox.shrink();
          },
        ),
      ],
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
