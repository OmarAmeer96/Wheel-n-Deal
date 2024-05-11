import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shred_prefs_constants.dart';
import 'package:wheel_n_deal/Features/user/orders/data/repos/get_user_orders_repo.dart';
import 'package:wheel_n_deal/Features/user/orders/logic/post_order_cubit/get_user_orders_state.dart';
import '../../../../../Core/networking/shared_prefs/shared_prefs.dart';

class GetUserOrdersCubit extends Cubit<GetUserOrdersState> {
  final GetUserOrdersRepo _getUserOrdersRepo;
  GetUserOrdersCubit(this._getUserOrdersRepo)
      : super(const GetUserOrdersState.initial());

  void emitGetUserOrdersState() async {
    emit(const GetUserOrdersState.loading());

    final response = await _getUserOrdersRepo.getUserOrders(
      SharedPrefs.getString(key: kToken)!,
      SharedPrefs.getInt(key: kUserId)!,
    );

    // Save a list of order IDs
    Future<void> saveOrderIds(List<String> orderIds) async {
      await SharedPrefs.setStringList(key: kOrderIds, value: orderIds);
    }

    // Load the list of order IDs
    Future<List<String>> loadOrderIds() async {
      return SharedPrefs.getStringList(key: kOrderIds) ?? [];
    }

    // Add an order ID to the list
    Future<void> addOrderId(String orderId) async {
      List<String> orderIds = await loadOrderIds();
      orderIds.add(orderId);
      await saveOrderIds(orderIds);
    }

    response.when(
      success: (getUserOrdersResponse) async {
        if (getUserOrdersResponse.status != 200) {
          emit(
            GetUserOrdersState.error(
              error: getUserOrdersResponse.message ?? '',
            ),
          );
        } else {
          // Save the order ID to the list
          // await addOrderId(
          //   getUserOrdersResponse.getUserOrdersResponseData!.id.toString(),
          // );
          // log("Order ID: ${getUserOrdersResponse.getUserOrdersResponseData!.id}");
          // log("Order IDs: ${await loadOrderIds()}");
          emit(GetUserOrdersState.success(getUserOrdersResponse));
        }
      },
      failure: (error) {
        emit(
          GetUserOrdersState.error(
            error: error.apiErrorModel.message ?? 'Something went wrong!',
          ),
        );
      },
    );
  }
}
