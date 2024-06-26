import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shared_prefs.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shred_prefs_constants.dart';
import 'package:wheel_n_deal/Features/commuter/post%20trip/data/repos/commuter_post_order_repo.dart';
import 'package:wheel_n_deal/Features/commuter/post%20trip/logic/commuter_post_trip_cubit/commuter_post_trip_state.dart';

class CommuterPostTripCubit extends Cubit<CommuterPostTripState> {
  final CommuterPostTripRepo _commuterPostTripRepo;
  CommuterPostTripCubit(this._commuterPostTripRepo)
      : super(const CommuterPostTripState.initial());

  final formKey = GlobalKey<FormState>();
  // Step 1
  TextEditingController fromAddressController =
      TextEditingController(text: "This is FROM test");
  TextEditingController toAddressController =
      TextEditingController(text: "This is TO test");
  TextEditingController location1Controller = TextEditingController();
  TextEditingController location2Controller = TextEditingController();
  TextEditingController location3Controller = TextEditingController();

  // Step 2
  TextEditingController timeOfTheTripController = TextEditingController();
  TextEditingController startAtController = TextEditingController();
  TextEditingController endAtController = TextEditingController();
  TextEditingController capacityController = TextEditingController();

  void emitPostTripState() async {
    emit(const CommuterPostTripState.loading());

    final response = await _commuterPostTripRepo.commuterPostTrip(
      SharedPrefs.getString(key: kToken)!,
      fromAddressController.text,
      toAddressController.text,
      [
        location1Controller.text,
        location2Controller.text,
        location3Controller.text,
      ],
      timeOfTheTripController.text,
      startAtController.text,
      endAtController.text,
      capacityController.text,
      SharedPrefs.getInt(key: kUserId)!,
    );

    /* // Save a list of order IDs
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
    } */

    response.when(
      success: (commuterPostTripResponse) async {
        if (commuterPostTripResponse.status != 200) {
          emit(
            CommuterPostTripState.error(
              error: commuterPostTripResponse.message ?? '',
            ),
          );
        } else {
          // // Save the order ID to the list
          // await addOrderId(
          //   commuterPostTripResponse.postOrderResponseData!.orderId.toString(),
          // );
          // log("Order ID: ${commuterPostTripResponse.postOrderResponseData!.orderId}");
          // log("Order IDs: ${await loadOrderIds()}");
          emit(CommuterPostTripState.success(commuterPostTripResponse));
        }
      },
      failure: (error) {
        emit(
          CommuterPostTripState.error(
            error: error.apiErrorModel.message ?? 'Something went wrong!',
          ),
        );
      },
    );
  }
}
