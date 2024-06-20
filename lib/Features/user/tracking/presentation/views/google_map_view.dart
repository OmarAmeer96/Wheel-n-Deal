import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Features/user/tracking/presentation/views/widgets/google%20map%20widgets/google_map_view_body.dart';

class GoogleMapView extends StatelessWidget {
  const GoogleMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GoogleMapViewBody(),
      ),
    );
  }
}
