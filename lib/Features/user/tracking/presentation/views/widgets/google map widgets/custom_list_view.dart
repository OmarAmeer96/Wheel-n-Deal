import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wheel_n_deal/Core/networking/google%20map%20services/map_services.dart';
import 'package:wheel_n_deal/Features/user/tracking/data/models/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:wheel_n_deal/Features/user/tracking/data/models/place_details_model/place_details_model.dart';


class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.places,
    required this.mapServices,
    required this.onPlaceSelect,
  });

  final List<PlaceAutocompleteModel> places;
  final MapServices mapServices;
  final void Function(PlaceDetailsModel) onPlaceSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(FontAwesomeIcons.mapMarkerAlt),
            title: Text(places[index].description!),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () async {
                var placeDetails = await mapServices.getPlaceDetails(
                    placeId: places[index].placeId.toString());
                onPlaceSelect(placeDetails);
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 0,
          );
        },
        itemCount: places.length,
      ),
    );
  }
}
