import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shred_prefs_constants.dart';
import 'package:wheel_n_deal/Features/user/orders/data/repos/delete_user_not_active_order.dart';
import 'package:wheel_n_deal/Features/user/orders/logic/delete_user_not_active_order_cubit/delete_user_not_active_order_state.dart';
import '../../../../../Core/networking/shared_prefs/shared_prefs.dart';

class DeleteUserNotActiveOrderCubit
    extends Cubit<DeleteUserNotActiveOrderState> {
  final DeleteUserNotActiveOrderRepo _deleteUserNotActiveOrderRepo;
  DeleteUserNotActiveOrderCubit(this._deleteUserNotActiveOrderRepo)
      : super(const DeleteUserNotActiveOrderState.initial());

  void emitDeleteNotActiveOrderState(int orderId) async {
    emit(const DeleteUserNotActiveOrderState.loading());

    final response = await _deleteUserNotActiveOrderRepo.deleteNotActiveOrder(
      SharedPrefs.getString(key: kToken)!,
      orderId,
    );

    response.when(
      success: (deleteUserNotActiveOrderResponse) {
        DeleteUserNotActiveOrderState.success(deleteUserNotActiveOrderResponse);
      },
      failure: (error) {
        emit(
          DeleteUserNotActiveOrderState.error(
            error: error.apiErrorModel.message ?? 'Something went wrong!',
          ),
        );
      },
    );
  }
}
